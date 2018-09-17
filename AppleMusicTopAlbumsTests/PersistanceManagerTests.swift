//
//  PersistanceManagerTests.swift
//  AppleMusicTopAlbumsTests
//
//  Created by Patel, Vandan (ETW - FLEX) on 9/16/18.
//  Copyright © 2018 Patel, Vandan (ETW - FLEX). All rights reserved.
//

import XCTest
import CoreData
@testable import AppleMusicTopAlbums

class PersistanceManagerTests: XCTestCase {
    func testPersistanceContainer() {
        let container = NSPersistentContainer(name: "AppleMusicTopAlbums")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if error != nil {
                XCTFail("Error getting persistance container")
            }
        })
    }
}
