//
//  Album+CoreDataClass.swift
//  AppleMusicTopAlbums
//
//  Created by Patel, Vandan (ETW - FLEX) on 9/11/18.
//  Copyright © 2018 Patel, Vandan (ETW - FLEX). All rights reserved.
//
//

import Foundation
import CoreData


public class Album: NSManagedObject, Codable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Album> {
        return NSFetchRequest<Album>(entityName: "Album")
    }

    @NSManaged public var artistName: String
    @NSManaged public var albumName: String
    @NSManaged public var albumReleaseDate: Date
    @NSManaged public var albumArtwork: String
    @NSManaged public var albumImage: Data
    @NSManaged public var copyrightInfo: String
    @NSManaged public var linkToAppStore: String
    @NSManaged public var feed: NSSet?

    enum CodingKeys: String, CodingKey {
        case artistName
        case albumName          = "name"
        case copyrightInfo      = "copyright"
        case albumArtwork       = "artworkUrl100"
        case albumReleaseDate   = "releaseDate"
        case linkToAppStore     = "url"
        case albumImage
        case feeds
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(artistName, forKey: .artistName)
        try container.encode(albumName, forKey: .albumName)
        try container.encode(copyrightInfo, forKey: .copyrightInfo)
        try container.encode(albumArtwork, forKey: .albumArtwork)
        try container.encode(albumReleaseDate, forKey: .albumReleaseDate)
        try container.encode(linkToAppStore, forKey: .linkToAppStore)
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Album", in: managedObjectContext)
            else {  fatalError("Failed to decode Subject!")  }
        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        artistName = try container.decodeIfPresent(String.self, forKey: .artistName) ?? "No Name"
        albumName = try container.decodeIfPresent(String.self, forKey: .albumName) ?? "No Name"
        copyrightInfo = try container.decodeIfPresent(String.self, forKey: .copyrightInfo) ?? "No Name"
        albumArtwork = try container.decodeIfPresent(String.self, forKey: .albumArtwork) ?? "No Name"
        albumReleaseDate = try container.decodeIfPresent(Date.self, forKey: .albumReleaseDate) ?? Date()
        linkToAppStore = try container.decodeIfPresent(String.self, forKey: .linkToAppStore) ?? ""
    }
}
