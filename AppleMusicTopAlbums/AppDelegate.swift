//
//  AppDelegate.swift
//  AppleMusicTopAlbums
//
//  Created by Patel, Vandan (ETW - FLEX) on 9/11/18.
//  Copyright © 2018 Patel, Vandan (ETW - FLEX). All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        guard let context = CodingUserInfoKey.context else {
            return false
        }

        let persistanceContainer = PersistanceManager().persistentContainer
        let decoder = JSONDecoder()
        decoder.userInfo[context] = persistanceContainer.viewContext
        decoder.dateDecodingStrategy = .formatted(basicDateFormatter)

        let netManager = NetworkManager(persistanceContainer: persistanceContainer,
                                        context: context,
                                        decoder: decoder)

        let mainVC = MainViewController(persistanceContainer: persistanceContainer, networkManager: netManager)
        let navVC = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        return true
    }
}

