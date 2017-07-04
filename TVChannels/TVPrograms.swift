//
//  TVPrograms.swift
//  TVChannels
//
//  Created by Alexey on 3/7/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Gloss

struct TVPrograms: Decodable {
    
    let channelId: Int?
    let programs: [TVProgram]?
    
    init?(json: JSON) {
        channelId = "channelId" <~~ json
        programs = "programs" <~~ json
    }
}
