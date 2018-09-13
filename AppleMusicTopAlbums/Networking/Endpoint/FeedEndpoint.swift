//
//  FeedEndpoint.swift
//  AppleMusicTopAlbums
//
//  Created by Patel, Vandan (ETW - FLEX) on 9/12/18.
//  Copyright © 2018 Patel, Vandan (ETW - FLEX). All rights reserved.
//

import Foundation

public enum FeedAPI {
    case getTopAlbums()
}

extension FeedAPI: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/") else {
            fatalError("Base url couldn't be configured")
        }
        return url
    }

    var path: String {
        switch self {
        case .getTopAlbums:
            return "us/apple-music/top-albums/all/50/non-explicit.json"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getTopAlbums:
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case .getTopAlbums:
            return .request
        }
    }

    var headers: HTTPHeaders? {
        switch self {
        case .getTopAlbums:
            return nil
        }
    }
}
