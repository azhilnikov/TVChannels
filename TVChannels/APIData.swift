//
//  APIData.swift
//  TVChannels
//
//  Created by Alexey on 4/7/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

enum TVAPIURL: String {
    case channels = "https://s3-ap-southeast-2.amazonaws.com/swm-ftp-s3/ios/channel_list.json"
    case program = "https://s3-ap-southeast-2.amazonaws.com/swm-ftp-s3/ios/channel_programs_"
}

enum TVAPIResult {
    case success
    case failure(Error)
}

enum TVAPIError: Error {
    case invalidURL
    case invalidResponse
    case invalidStatusCode
    case invalidData
    case invalidJSONFormat
}

extension TVAPIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
            
        case .invalidResponse:
            return NSLocalizedString("Invalid Response", comment: "")
            
        case .invalidStatusCode:
            return NSLocalizedString("Invalid status code", comment: "")
            
        case .invalidData:
            return NSLocalizedString("Invalid data", comment: "")
            
        case .invalidJSONFormat:
            return NSLocalizedString("Invalid JSON format", comment: "")
        }
    }
}
