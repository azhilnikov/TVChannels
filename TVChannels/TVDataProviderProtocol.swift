//
//  TVDataProviderProtocol.swift
//  TVChannels
//
//  Created by Alexey on 4/7/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

protocol TVDataProviderProtocol {
    var count: Int { get }
}

protocol TVChannelsDataProviderProtocol: TVDataProviderProtocol {
    subscript(index: Int) -> TVChannel? { get }
}

protocol TVProgramsDataProviderProtocol: TVDataProviderProtocol {
    subscript(index: Int) -> TVProgram? { get }
}
