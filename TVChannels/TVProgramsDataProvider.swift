//
//  TVProgramsDataProvider.swift
//  TVChannels
//
//  Created by Alexey on 4/7/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Gloss

class TVProgramsDataProvider: TVProgramsDataProviderProtocol {

    var count: Int {
        return tvPrograms.count
    }
    
    subscript(index: Int) -> TVProgram? {
        return index >= 0 && index < self.count ? tvPrograms[index] : nil
    }
    
    private var tvPrograms = [TVProgram]()
    private var dateFormatter = DateFormatter()
    
    func fetch(_ channelId: Int, completion: @escaping (TVAPIResult) -> Void) {
        
        let url = TVAPIURL.program.rawValue + "\(channelId).json"
        
        APIService.shared.fetch(url) { [weak self] (data, error) in
            switch error {
            case .success:
                guard let tvProgramsData = data else {
                    completion(.failure(TVAPIError.invalidData))
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: tvProgramsData,
                                                                options: .allowFragments) as AnyObject
                    
                    if let jsonData = json as? JSON, let tvPrograms = TVPrograms(json: jsonData) {
                        self?.update(tvPrograms)
                        completion(.success)
                        return
                    }
                    completion(.failure(TVAPIError.invalidJSONFormat))
                }
                catch let jsonError {
                    completion(.failure(jsonError))
                }
                
            case .failure(_):
                completion(error)
            }
        }
    }
    
    private func update(_ data: TVPrograms) {
        self.tvPrograms.removeAll()
        
        if let tvProgramsData = data.programs {
            // Append sequence sorted by startTime
            self.tvPrograms.append(contentsOf: tvProgramsData.sorted {
                if let firstStartDate = $0.0.startTime, let secondStartDate = $0.1.startTime,
                    let firstDate = self.dateFormatter.convert(from: firstStartDate),
                    let secondDate = self.dateFormatter.convert(from: secondStartDate) {
                    return .orderedAscending == firstDate.compare(secondDate)
                }
                return false
            })
        }
    }
}
