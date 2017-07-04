//
//  TVChannel.swift
//  TVChannels
//
//  Created by Alexey on 3/7/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Gloss

struct TVChannel: Decodable {
    
    let channelId: Int?
    let name: String?
    let displayOrder: Int?
    
    init?(json: JSON) {
        channelId = "channelId" <~~ json
        name = "name" <~~ json
        displayOrder = "displayOrder" <~~ json
    }
}
