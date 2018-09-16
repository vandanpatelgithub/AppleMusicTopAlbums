//
//  DetailedViewController.swift
//  AppleMusicTopAlbums
//
//  Created by Patel, Vandan (ETW - FLEX) on 9/15/18.
//  Copyright © 2018 Patel, Vandan (ETW - FLEX). All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    var album: Album?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        guard let theAlbum = album else { return }
        print("Name of the albums: \(theAlbum.albumName)")
    }
}
