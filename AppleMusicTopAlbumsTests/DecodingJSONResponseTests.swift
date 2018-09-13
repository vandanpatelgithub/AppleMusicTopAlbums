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
            guard let firstAlbum = feed.albums.firstObject as? Album else {
                XCTFail("Getting first album failed")
                return
            }
            XCTAssertEqual(firstAlbum.artistName, "Ozuna")
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

    func testEmptyResultsJSONResponse() {
        guard
            let data = getJSONData(forResource: "StubbedEmptyResultsResponse", ofType: "json"),
            let context = CodingUserInfoKey.context else {
                XCTFail("Getting JSONData or Context Failed")
                return
        }

        let decoder = JSONDecoder()
        decoder.userInfo[context] = persistanceContainer.viewContext
        decoder.dateDecodingStrategy = .formatted(basicDateFormatter)
        do {
            let feedContainer = try decoder.decode(FeedContainer.self, from: data)
            XCTAssertEqual(feedContainer.feed?.albums.count, 0)
            XCTAssertEqual(feedContainer.feed?.title, "Top Albums")

        } catch let error {
            XCTAssertNotNil(error)
        }
    }

    func testEmptyFeedJSONResponse() {
        guard
            let data = getJSONData(forResource: "EmptyFeedResponse", ofType: "json"),
            let context = CodingUserInfoKey.context else {
                XCTFail("Getting JSONData or Context Failed")
                return
        }
        let decoder = JSONDecoder()
        decoder.userInfo[context] = persistanceContainer.viewContext
        decoder.dateDecodingStrategy = .formatted(basicDateFormatter)
        do {
            let feedContainer = try decoder.decode(FeedContainer.self, from: data)
            XCTAssertNotNil(feedContainer.feed)
            XCTAssertEqual(feedContainer.feed?.title, "")
            XCTAssertEqual(feedContainer.feed?.albums.count, 0)
        } catch let error {
            XCTAssertNotNil(error)
        }
    }
}
