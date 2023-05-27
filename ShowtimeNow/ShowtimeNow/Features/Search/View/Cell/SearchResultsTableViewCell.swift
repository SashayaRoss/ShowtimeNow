//
//  SearchResultsTableViewCell.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

final class SearchResultsTableViewCell: UITableViewCell {
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.tintColor = .darkBlue()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(posterImageView)
        contentView.addSubview(title)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(title)
        
        contentView.clipsToBounds = true
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.smallPadding),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.smallPadding),
            
            title.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            title.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.smallPadding),
        ])
        
    }
    
    private struct Constants {
        static let smallPadding: CGFloat = 10.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        title.text = nil
    }
    
    func configure(with viewModel: SearchResultsTableViewCellViewModel) {
        title.text = viewModel.title
//        posterImageView // viewModel.url
    }
}
