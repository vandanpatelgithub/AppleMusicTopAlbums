//
//  AlbumCell.swift
//  AppleMusicTopAlbums
//
//  Created by Patel, Vandan (ETW - FLEX) on 9/15/18.
//  Copyright © 2018 Patel, Vandan (ETW - FLEX). All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {

    // MARK: Outlets Initialization

    private lazy var albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16.0
        return imageView
    }()

    private lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Default Album Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 0
        return label
    }()

    private lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Default Artist Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()


    // MARK: ViewModel
    var mainAlbumViewModel: MainAlbumViewModel! {
        didSet {
            albumImageView.image    = mainAlbumViewModel.albumImage
            albumNameLabel.text     = mainAlbumViewModel.albumName
            artistNameLabel.text    = mainAlbumViewModel.artistName
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Adding Subviews
    fileprivate func setupSubViews() {
        addSubview(albumImageView)
        addSubview(albumNameLabel)
        addSubview(artistNameLabel)
    }

    // MARK: Constraints
    fileprivate func setupConstraints() {
        let albumImageViewConstraints = [
            albumImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            albumImageView.widthAnchor.constraint(equalToConstant: 200.0),
            albumImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            albumImageView.heightAnchor.constraint(equalToConstant: 200.0)
        ]
        NSLayoutConstraint.activate(albumImageViewConstraints)

        let albumNameLabelConstraints = [
            albumNameLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 16),
            albumNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            albumNameLabel.topAnchor.constraint(equalTo: albumImageView.topAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(albumNameLabelConstraints)

        let artistNameLabelConstraints = [
            artistNameLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 16),
            artistNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 8)
        ]
        NSLayoutConstraint.activate(artistNameLabelConstraints)
    }
}
