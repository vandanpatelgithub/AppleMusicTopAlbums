//
//  FeedEndpointTests.swift
//  AppleMusicTopAlbumsTests
//
//  Created by Patel, Vandan (ETW - FLEX) on 9/12/18.
//  Copyright © 2018 Patel, Vandan (ETW - FLEX). All rights reserved.
//

import XCTest
@testable import AppleMusicTopAlbums

class FeedEndpointTests: XCTestCase {
    func testGetAlbumsEndpoint() {
        let endpoint = FeedAPI.topAlbums
        XCTAssertEqual(endpoint.baseURL.absoluteString, "https://rss.itunes.apple.com/api/v1/")
        XCTAssertEqual(endpoint.path, "us/apple-music/top-albums/all/50/non-explicit.json")
        XCTAssertEqual(endpoint.httpMethod, .get)
        XCTAssertEqual(endpoint.task, HTTPTask.request)
        XCTAssertEqual(endpoint.headers, nil)
    }
}
