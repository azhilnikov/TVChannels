//
//  TVChannelsTests.swift
//  TVChannelsTests
//
//  Created by Alexey on 3/7/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import XCTest
@testable import TVChannels

class TVChannelsTests: XCTestCase {
    
    var channelsDataProvider: TVChannelsDataProvider!
    var programsDataProvider: TVProgramsDataProvider!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        channelsDataProvider = TVChannelsDataProvider()
        programsDataProvider = TVProgramsDataProvider()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTVChannelsData() {
        let channelsExpectation = expectation(description: "Channels")
        channelsDataProvider.fetch() { (result) in
            switch result {
            case .success:
                break
                
            case .failure(_):
                XCTFail()
            }
            channelsExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotEqual(self.channelsDataProvider.count, 0)
            
            for index in 0..<self.channelsDataProvider.count {
                let tvChannel = self.channelsDataProvider[index]
                XCTAssertNotNil(tvChannel?.channelId)
                XCTAssertNotNil(tvChannel?.name)
                XCTAssertNotNil(tvChannel?.displayOrder)
            }
        }
    }
    
    func testTVProgramsData() {
        let channelsExpectation = expectation(description: "Channels")
        channelsDataProvider.fetch() { (result) in
            switch result {
            case .success:
                break
                
            case .failure(_):
                XCTFail()
            }
            channelsExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotEqual(self.channelsDataProvider.count, 0)
        }
        
        // Download all programs for every channel
        
        for channelIndex in 0..<channelsDataProvider.count {
            let channelId = channelsDataProvider[channelIndex]?.channelId
            XCTAssertNotNil(channelId)
            
            let programsExpectation = expectation(description: "Programs")
            programsDataProvider.fetch(channelId!) { (result) in
                switch result {
                case .success:
                    break
                    
                case .failure(_):
                    XCTFail()
                }
                programsExpectation.fulfill()
            }
            
            waitForExpectations(timeout: 1) { (error) in
                XCTAssertNotEqual(self.programsDataProvider.count, 0)
                
                for index in 0..<self.programsDataProvider.count {
                    let tvProgram = self.programsDataProvider[index]
                    XCTAssertNotNil(tvProgram?.id)
                    XCTAssertNotNil(tvProgram?.title)
                    XCTAssertNotNil(tvProgram?.synopsis)
                    XCTAssertNotNil(tvProgram?.startTime)
                    XCTAssertNotNil(tvProgram?.endTime)
                    XCTAssertNotNil(tvProgram?.imageURL)
                }
            }
        }
    }
}
