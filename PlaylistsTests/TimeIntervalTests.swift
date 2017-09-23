//
//  PlaylistsTests.swift
//  PlaylistsTests
//
//  Created by Damien Dorizy on 23/09/2017.
//  Copyright © 2017 CfApps. All rights reserved.
//

import XCTest
@testable import Playlists

class TimeIntervalTests: XCTestCase {
    
    // MARK: - Constants
    private let secondsDuration: TimeInterval = 50
    private let minuteDuration: TimeInterval = 60
    private let minutesDuration: TimeInterval = 2438
    private let hourDuration: TimeInterval = 3883
    private let hoursDuration: TimeInterval = 587874
    
    func testFormatingSecondsDuration() {
        XCTAssertEqual("0:50", secondsDuration.toFormattedString())
    }
    
    func testFormatingMinuteDuration() {
        XCTAssertEqual("1:00", minuteDuration.toFormattedString())
    }
    
    func testFormatingMinutesDuration() {
        XCTAssertEqual("40:38", minutesDuration.toFormattedString())
    }
    
    func testFormatingHourDuration() {
        XCTAssertEqual("1:04:43", hourDuration.toFormattedString())
    }
    
    func testFormatingHoursDuration() {
        XCTAssertEqual("163:17:54", hoursDuration.toFormattedString())
    }
    
}
