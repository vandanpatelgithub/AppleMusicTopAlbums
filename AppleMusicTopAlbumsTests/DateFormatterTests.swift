//
//  DateFormatterTests.swift
//  AppleMusicTopAlbumsTests
//
//  Created by Patel, Vandan (ETW - FLEX) on 9/16/18.
//  Copyright © 2018 Patel, Vandan (ETW - FLEX). All rights reserved.
//

import XCTest
@testable import AppleMusicTopAlbums

class DateFormatterTests: XCTestCase {

    func testBasicDateFormatter() {
        let stringDate = "2018-08-24"
        let date = basicDateFormatter.date(from: stringDate)
        XCTAssertNotNil(date)
        XCTAssertEqual(basicDateFormatter.string(from: date ?? Date()), stringDate)
    }

    func testUserFriendlyDateFormatter() {
        let stringDate = "2018-08-24"
        let basicDate = basicDateFormatter.date(from: stringDate)
        let expectedDate = "Aug 24, 2018"
        XCTAssertNotNil(basicDate)
        XCTAssertEqual(userFriendlyDateFormatter.string(from: basicDate ?? Date()), expectedDate)
    }
}
