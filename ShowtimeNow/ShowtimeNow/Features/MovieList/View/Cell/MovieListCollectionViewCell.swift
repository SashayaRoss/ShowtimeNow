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
    
    private let favouriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .turquoise()
        button.backgroundColor = .darkBlue().withAlphaComponent(0.8)
        button.layer.cornerRadius = 8
        button.contentMode = .scaleAspectFill
        return button
    }()

    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var isFavourite: Bool = false {
        didSet {
            let image = isFavourite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            favouriteButton.setImage(image, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(imageView)
        contentView.addSubview(favouriteButton)
        contentView.addSubview(title)
        
        contentView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        
        let imageSize = contentView.height - Constants.bigPadding
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.smallPadding),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.smallPadding),
            imageView.heightAnchor.constraint(equalToConstant: imageSize),
            
            favouriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.smallPadding),
            favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.smallPadding),
            favouriteButton.heightAnchor.constraint(equalToConstant: Constants.starIconSize),
            favouriteButton.widthAnchor.constraint(equalToConstant: Constants.starIconSize),
            
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
        viewModel.getImage { image in
            self.imageView.image = image
        }
        
        favouriteButton.addTarget(self, action: #selector(likedMovie), for: .touchUpInside)
    }
    
    @objc func likedMovie() {
        isFavourite = isFavourite ? false : true
        // TODO:
    }
    
    private struct Constants {
        static let smallPadding: CGFloat = 10.0
        static let bigPadding: CGFloat = 60.0
        static let starIconSize: CGFloat = 40.0
    }
}
