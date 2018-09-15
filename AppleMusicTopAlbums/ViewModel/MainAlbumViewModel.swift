//
//  MainAlbumViewModel.swift
//  AppleMusicTopAlbums
//
//  Created by Patel, Vandan (ETW - FLEX) on 9/15/18.
//  Copyright © 2018 Patel, Vandan (ETW - FLEX). All rights reserved.
//

import UIKit
import Foundation

struct MainAlbumViewModel {
    let artistName: String
    let albumName: String
    let albumImage: UIImage?

    init(album: Album) {
        self.artistName = album.artistName
        self.albumName = album.albumName
        if let data = album.albumImage {
            self.albumImage = UIImage(data: data)
        }   else {
            self.albumImage = nil
        }
    }
}
