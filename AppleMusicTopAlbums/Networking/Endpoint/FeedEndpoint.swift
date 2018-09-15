//
//  FeedEndpoint.swift
//  AppleMusicTopAlbums
//
//  Created by Patel, Vandan (ETW - FLEX) on 9/12/18.
//  Copyright © 2018 Patel, Vandan (ETW - FLEX). All rights reserved.
//

import Foundation

public enum FeedAPI {
    case topAlbums
    case imageData(imageURL: String)
}

extension FeedAPI: EndPointType {
    var baseURL: URL {
        switch self {
        case .topAlbums:
            guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/") else {
                fatalError("Base url couldn't be configured")
            }
            return url
        case let .imageData(imageURL):
            guard let url = URL(string: imageURL) else {
                fatalError("Base url couldn't be configured")
            }
            return url
        }
    }

    var path: String {
        switch self {
        case .topAlbums:
            return "us/apple-music/top-albums/all/50/non-explicit.json"
        case .imageData:
            return ""
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .topAlbums, .imageData:
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case .topAlbums, .imageData:
            return .request
        }
    }

    var headers: HTTPHeaders? {
        switch self {
        case .topAlbums, .imageData:
            return nil
        }
    }
}
