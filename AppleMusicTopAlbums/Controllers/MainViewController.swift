//
//  MainViewController.swift
//  AppleMusicTopAlbums
//
//  Created by Patel, Vandan (ETW - FLEX) on 9/11/18.
//  Copyright © 2018 Patel, Vandan (ETW - FLEX). All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController {

    private let persistanceContainer: NSPersistentContainer

    init(persistanceContainer: NSPersistentContainer) {
        self.persistanceContainer = persistanceContainer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
    }
}
