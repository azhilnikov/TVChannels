//
//  TVProgram.swift
//  TVChannels
//
//  Created by Alexey on 3/7/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Gloss

struct TVProgram: Decodable {
    
    let id: Int?
    let title: String?
    let synopsis: String?
    let startTime: String?
    let endTime: String?
    let imageURL: String?
    
    init?(json: JSON) {
        id = "id" <~~ json
        title = "title" <~~ json
        synopsis = "synopsis" <~~ json
        startTime = "start_time" <~~ json
        endTime = "end_time" <~~ json
        imageURL = "imageUrl" <~~ json
    }
}
