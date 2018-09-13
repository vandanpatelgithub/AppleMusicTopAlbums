//
//  DecodingJSONResponseTests.swift
//  AppleMusicTopAlbumsTests
//
//  Created by Patel, Vandan (ETW - FLEX) on 9/12/18.
//  Copyright © 2018 Patel, Vandan (ETW - FLEX). All rights reserved.
//

import XCTest
@testable import AppleMusicTopAlbums

class DecodingJSONResponseTests: XCTestCase {
    let persistanceContainer = PersistanceManager().persistentContainer

    func testDecodingJSONResponseSuccess() {
        guard
            let data = getJSONData(forResource: "StubbedTopAlbums", ofType: "json"),
            let context = CodingUserInfoKey.context else {
                XCTFail("Getting JSONData or Context Failed")
                return
        }

        let decoder = JSONDecoder()
        decoder.userInfo[context] = persistanceContainer.viewContext
        decoder.dateDecodingStrategy = .formatted(basicDateFormatter)
        do {
            let feedContainer = try decoder.decode(FeedContainer.self, from: data)
            XCTAssertNotNil(feedContainer)
            guard let feed = feedContainer.feed else {
                XCTFail("Feed inside FeedContainer shouldn't be nil")
                return
            }
            XCTAssertEqual(feed.title, "Top Albums")
        } catch {
            XCTFail("Decoding Failed")
        }
    }

    func testDecodingEmptyJSONResponse() {
        guard
            let data = getJSONData(forResource: "EmptyResponse", ofType: "json"),
            let context = CodingUserInfoKey.context else {
                XCTFail("Getting JSONData or Context Failed")
                return
        }

        let decoder = JSONDecoder()
        decoder.userInfo[context] = persistanceContainer.viewContext
        decoder.dateDecodingStrategy = .formatted(basicDateFormatter)
        do {
            let feedContainer = try decoder.decode(FeedContainer.self, from: data)
            XCTAssertNil(feedContainer.feed)
        } catch let error {
            XCTAssertNotNil(error)
        }
    }

    func testCorruptJSONResponse() {
        guard let _ = getJSONData(forResource: "CorruptResponse", ofType: "json") else {
            return
        }
        XCTFail("Test shouldn't succeed")
    }
}
