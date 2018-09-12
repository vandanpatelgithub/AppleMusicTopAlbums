//
//  Feed+CoreDataClass.swift
//  AppleMusicTopAlbums
//
//  Created by Patel, Vandan (ETW - FLEX) on 9/11/18.
//  Copyright © 2018 Patel, Vandan (ETW - FLEX). All rights reserved.
//
//

import Foundation
import CoreData


public class Feed: NSManagedObject, Codable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Feed> {
        return NSFetchRequest<Feed>(entityName: "Feed")
    }

    @NSManaged public var title: String
    @NSManaged public var albums: Set<Album>
    @NSManaged public var feedContainer: FeedContainer?

    enum CodingKeys: String, CodingKey {
        case title
        case albums = "results"
        case feedContainer
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(albums, forKey: .albums)
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Feed", in: managedObjectContext) else {  fatalError("Failed to decode Subject!")  }
        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        albums = try container.decodeIfPresent(Set<Album>.self, forKey: .albums) ?? []
    }
}
