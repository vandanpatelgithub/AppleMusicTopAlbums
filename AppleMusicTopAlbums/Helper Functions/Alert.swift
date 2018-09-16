//
//  AlertViewController.swift
//  AppleMusicTopAlbums
//
//  Created by Patel, Vandan (ETW - FLEX) on 9/14/18.
//  Copyright © 2018 Patel, Vandan (ETW - FLEX). All rights reserved.
//

import UIKit

struct Alert {

    let vc: UIViewController
    let title: String
    let message: String
    let actions: [UIAlertAction]

    init(vc: UIViewController, title: String, message: String, actions: [UIAlertAction]) {
        self.vc        = vc
        self.title     = title
        self.message   = message
        self.actions   = actions
    }

    func showAlert() {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        vc.present(alert, animated: true)
    }
}
