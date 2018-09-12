//
//  FeedContainer+CoreDataClass.swift
//  AppleMusicTopAlbums
//
//  Created by Patel, Vandan (ETW - FLEX) on 9/11/18.
//  Copyright © 2018 Patel, Vandan (ETW - FLEX). All rights reserved.
//
//

import Foundation
import CoreData


public class FeedContainer: NSManagedObject, Codable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FeedContainer> {
        return NSFetchRequest<FeedContainer>(entityName: "FeedContainer")
    }

    @NSManaged public var feed: Feed

    enum CodingKeys: String, CodingKey {
        case feed
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(feed, forKey: .feed)
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "FeedContainer", in: managedObjectContext) else {  fatalError("Failed to decode Subject!")  }
        self.init(entity: entity, insertInto: managedObjectContext)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        feed = try container.decodeIfPresent(Feed.self, forKey: .feed) ?? Feed()

    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
