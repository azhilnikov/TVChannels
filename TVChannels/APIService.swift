//
//  APIService.swift
//  TVChannels
//
//  Created by Alexey on 3/7/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    func fetch(_ url: String, completion: @escaping (Data?, TVAPIResult) -> Void) {
        guard let url = URL(string: url) else {
            completion(nil, .failure(TVAPIError.invalidURL))
            return
        }
        
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let taskError = error {
                completion(nil, .failure(taskError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .failure(TVAPIError.invalidResponse))
                return
            }
            
            if 200 != httpResponse.statusCode {
                completion(nil, .failure(TVAPIError.invalidStatusCode))
                return
            }
            
            guard let tvChannelsData = data else {
                completion(nil, .failure(TVAPIError.invalidData))
                return
            }
            completion(tvChannelsData, .success)
        }
        task.resume()
    }
}
