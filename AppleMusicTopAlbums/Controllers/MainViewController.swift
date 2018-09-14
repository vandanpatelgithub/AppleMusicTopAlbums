//
//  MainViewController.swift
//  AppleMusicTopAlbums
//
//  Created by Patel, Vandan (ETW - FLEX) on 9/11/18.
//  Copyright © 2018 Patel, Vandan (ETW - FLEX). All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UITableViewController {

    private let persistanceContainer: NSPersistentContainer
    private let networkManager: NetworkManager
    private var albums = [Album]()
    private let cellID = "albumCell"

    init(persistanceContainer: NSPersistentContainer, networkManager: NetworkManager) {
        self.persistanceContainer = persistanceContainer
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Top Albums"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }

    override func viewWillAppear(_ animated: Bool) {
        networkManager.getTopAlbums { [weak self] (albums, error) in
            guard let strongSelf = self else { return }
            if let error = error { print(error) }
            if let albums = albums {
                strongSelf.albums = albums
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let album = albums[indexPath.row]
        cell.textLabel?.text = album.albumName
        return cell
    }
}
