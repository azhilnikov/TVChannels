//
//  TVChannels.swift
//  TVChannels
//
//  Created by Alexey on 3/7/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Gloss

struct TVChannels: Decodable {
    
    let channels: [TVChannel]?
    
    init?(json: JSON) {
        channels = "channels" <~~ json
    }
}
