//
//  TVChannelsDataProvider.swift
//  TVChannels
//
//  Created by Alexey on 3/7/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Gloss

class TVChannelsDataProvider: TVChannelsDataProviderProtocol {
    
    var count: Int {
        return tvChannels.count
    }
    
    subscript(index: Int) -> TVChannel? {
        return index >= 0 && index < self.count ? tvChannels[index] : nil
    }
    
    private var tvChannels = [TVChannel]()
    
    func fetch(completion: @escaping (TVAPIResult) -> Void) {
        
        APIService.shared.fetch(TVAPIURL.channels.rawValue) { [weak self] (data, error) in
            switch error {
            case .success:
                guard let tvChannelsData = data else {
                    completion(.failure(TVAPIError.invalidData))
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: tvChannelsData,
                                                                options: .allowFragments) as AnyObject
                    
                    if let jsonData = json as? JSON, let tvChannels = TVChannels(json: jsonData) {
                        self?.update(tvChannels)
                        completion(.success)
                        return
                    }
                    completion(.failure(TVAPIError.invalidJSONFormat))
                }
                catch let jsonError {
                    completion(.failure(jsonError))
                }
                
            case .failure(_ ):
                completion(error)
            }
        }
    }
    
    private func update(_ data: TVChannels) {
        tvChannels.removeAll()
        
        if let tvChannelsData = data.channels {
            // Append sequence sorted by displayOrder
            self.tvChannels.append(contentsOf: tvChannelsData.sorted {
                if let firstDisplayOrder = $0.0.displayOrder,
                    let secondDisplayOrder = $0.1.displayOrder {
                    return firstDisplayOrder < secondDisplayOrder
                }
                return false
            })
        }
    }
}
