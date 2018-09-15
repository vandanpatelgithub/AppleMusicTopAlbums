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

    private let networkManager: NetworkManager
    private var albums = [Album]()
    private var feed: Feed?
    private let cellID = "albumCell"
    private lazy var loadingVC = LoadingViewController()
    let imageDataDispatchGroup = DispatchGroup()

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Top Albums"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }

    override func viewWillAppear(_ animated: Bool) {
        add(loadingVC)
        networkManager.getTopAlbums { [weak self] (feed, error) in
            guard let strongSelf = self else { return }
            if let error = error { strongSelf.handleError(error) }
            if let feed = feed {
                guard let albumsArray = feed.albums.array as? [Album] else {
                    return
                }
                strongSelf.albums = albumsArray
                strongSelf.loadImageData(albumsArray, feed)
            }
        }
    }

    func handleError(_ error: String) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.loadingVC.remove()
            Alert.showAlert(on: strongSelf, with: "ERROR", and: error)
        }
    }

    fileprivate func loadImageData(_ albumsArray: [Album], _ feed: Feed) {
        for album in albumsArray {
            imageDataDispatchGroup.enter()
            networkManager.getImageData(for: album.albumArtwork, completion: { [weak self] (data, error) in
                guard let strongSelf = self else {
                    return
                }
                if let error = error {
                    strongSelf.handleError(error)
                }
                if let data = data { album.albumImage = data }
                strongSelf.imageDataDispatchGroup.leave()
            })
        }

        imageDataDispatchGroup.notify(queue: .main, execute: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.loadingVC.remove()
            strongSelf.navigationItem.title = feed.title
            PersistanceManager.shared.save()
            strongSelf.fetchFeedContainer()
            strongSelf.tableView.reloadData()
        })
    }

    fileprivate func fetchFeedContainer() {
        guard (try? PersistanceManager.shared.context.fetch(FeedContainer.fetchRequest()) as? [FeedContainer]) != nil else {
            return
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
