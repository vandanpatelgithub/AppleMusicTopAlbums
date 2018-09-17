//
//  DetailedViewController.swift
//  AppleMusicTopAlbums
//
//  Created by Patel, Vandan (ETW - FLEX) on 9/15/18.
//  Copyright © 2018 Patel, Vandan (ETW - FLEX). All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    var album: Album! {
        didSet {
            albumImageView.image = UIImage(data: album.albumImage ?? Data())
            albumNameLabel.text = album.albumName
            artistNameLabel.text = album.artistName
            albumReleaseDate.text = userFriendlyDateFormatter.string(from: album.albumReleaseDate)
            albumCopyrightInfo.text = album.copyrightInfo
            linkToAppStore.text = album.linkToAppStore
        }
    }

    // MARK: UI Initialization

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 12.0
        return stackView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16.0
        imageView.alpha = 0.0
        return imageView
    }()

    private lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Default Album Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 0
        label.alpha = 0.0
        return label
    }()

    private lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Default Artist Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .gray
        label.numberOfLines = 0
        label.alpha = 0.0
        return label
    }()

    private lazy var albumReleaseDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .gray
        label.numberOfLines = 0
        label.alpha = 0.0
        return label
    }()

    private lazy var albumCopyrightInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.italicSystemFont(ofSize: 14.0)
        label.textColor = .gray
        label.numberOfLines = 0
        label.alpha = 0.0
        return label
    }()

    private lazy var linkToAppStore: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(linkLabedTapped(_:)))
        label.addGestureRecognizer(tapGesture)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .gray
        label.numberOfLines = 0
        label.alpha = 0.0
        return label
    }()

    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubViews()
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateLabelsAndImage()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: stackView.frame.width, height: stackView.frame.height)
    }

    // MARK: Animation
    fileprivate func animateLabelsAndImage() {
        albumImageView.transform = CGAffineTransform(translationX: -250.0, y: 0)
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.albumImageView.transform = .identity
            self?.albumImageView.alpha = 1.0
        }, completion: nil)

        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.albumNameLabel.alpha = 1.0
        }) { (_) in
            UIView.animate(withDuration: 0.1, animations: { [weak self] in
                self?.artistNameLabel.alpha = 1.0
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.1, animations: { [weak self] in
                        self?.albumReleaseDate.alpha = 1.0
                        }, completion: { (_) in
                            UIView.animate(withDuration: 0.1, animations: { [weak self] in
                                self?.albumCopyrightInfo.alpha = 1.0
                                }, completion: { (_) in
                                    UIView.animate(withDuration: 0.1, animations: { [weak self] in
                                        self?.linkToAppStore.alpha = 1.0
                                        }, completion: nil)
                            })
                    })
            })
        }
    }

    // MARK: Add Subviews
    fileprivate func setupSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(albumImageView)
        stackView.addArrangedSubview(albumNameLabel)
        stackView.addArrangedSubview(artistNameLabel)
        stackView.addArrangedSubview(albumReleaseDate)
        stackView.addArrangedSubview(albumCopyrightInfo)
        stackView.addArrangedSubview(linkToAppStore)
    }

    // MARK: Add Constraints
    fileprivate func setupConstraints() {
        let scrollViewConstraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
        ]
        NSLayoutConstraint.activate(scrollViewConstraints)

        let stackViewConstraints = [
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]
        NSLayoutConstraint.activate(stackViewConstraints)

        let albumNameLabelConstraints = [
            albumNameLabel.leadingAnchor.constraint(equalTo: albumImageView.leadingAnchor, constant: 0),
            albumNameLabel.trailingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(albumNameLabelConstraints)

        let artistNameLabelConstraints = [
            artistNameLabel.leadingAnchor.constraint(equalTo: albumImageView.leadingAnchor, constant: 0),
            artistNameLabel.trailingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(artistNameLabelConstraints)

        let albumReleaseDateConstraints = [
            albumReleaseDate.leadingAnchor.constraint(equalTo: albumImageView.leadingAnchor, constant: 0),
            albumReleaseDate.trailingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(albumReleaseDateConstraints)

        let albumCopyrightInfoConstraints = [
            albumCopyrightInfo.leadingAnchor.constraint(equalTo: albumImageView.leadingAnchor, constant: 0),
            albumCopyrightInfo.trailingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(albumCopyrightInfoConstraints)

        let linkToAppStoreConstraints = [
            linkToAppStore.leadingAnchor.constraint(equalTo: albumImageView.leadingAnchor, constant: 0),
            linkToAppStore.trailingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 0),
        ]
        NSLayoutConstraint.activate(linkToAppStoreConstraints)
    }

    // MARK: Actions
    @objc fileprivate func linkLabedTapped(_ sender: UITapGestureRecognizer) {
        let label = sender.view as! UILabel
        label.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.5, animations: {
            label.transform = .identity
        }) { [weak self] (_) in
            guard let strongSelf = self, let url = URL(string: strongSelf.album.linkToAppStore) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
