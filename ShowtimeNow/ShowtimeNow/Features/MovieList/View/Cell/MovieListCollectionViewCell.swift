//
//  MovieListCollectionViewCell.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

final class MovieListCollectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.tintColor = .darkBlue()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let starIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star")
        imageView.tintColor = .turquoise()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        contentView.addSubview(imageView)
        contentView.addSubview(starIconView)
        contentView.addSubview(title)
        
        contentView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        starIconView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        
        let imageSize = contentView.height - Constants.bigPadding
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.smallPadding),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.smallPadding),
            imageView.heightAnchor.constraint(equalToConstant: imageSize),
            
            starIconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.smallPadding),
//            starIconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.smallPadding),
            starIconView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.smallPadding),
            starIconView.heightAnchor.constraint(equalToConstant: Constants.starIconSize),
            
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -Constants.smallPadding),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        title.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private func setupAppearance() {
        layer.cornerRadius = 4.0
        clipsToBounds = true
        backgroundColor = .customtGray()
    }
    
    func configure(with viewModel: MovieListCellViewModel) {
        title.text = viewModel.title
    }
    
    private struct Constants {
        static let smallPadding: CGFloat = 10.0
        static let bigPadding: CGFloat = 40.0
        static let starIconSize: CGFloat = 30.0
    }
}
