//
//  MovieDetailsLayoutManager.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

final class MovieDetailsLayoutManager {
    private func setupHierarchy(in view: MovieDetailsViewInterface) {
        view.addSubview(view.scrollView)
        view.scrollView.addSubview(view.imageView)
        view.scrollView.addSubview(view.title)
        view.scrollView.addSubview(view.releaseDate)
        view.scrollView.addSubview(view.rating)
        view.scrollView.addSubview(view.favouriteButton)
        view.scrollView.addSubview(view.overview)
    }
    
    private func setupConstraints(in view: MovieDetailsViewInterface) {
        view.scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.imageView.translatesAutoresizingMaskIntoConstraints = false
        view.title.translatesAutoresizingMaskIntoConstraints = false
        view.releaseDate.translatesAutoresizingMaskIntoConstraints = false
        view.rating.translatesAutoresizingMaskIntoConstraints = false
        view.favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        view.overview.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            view.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view.scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            view.imageView.topAnchor.constraint(equalTo: view.scrollView.topAnchor),
            view.imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.smallPadding),
            view.imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.smallPadding),
            view.imageView.heightAnchor.constraint(equalToConstant: Constants.imageSize),

            view.title.topAnchor.constraint(equalTo: view.imageView.bottomAnchor, constant: Constants.smallPadding),
            view.title.leadingAnchor.constraint(equalTo: view.imageView.leadingAnchor),
            
            view.favouriteButton.centerYAnchor.constraint(equalTo: view.title.centerYAnchor),
            view.favouriteButton.leadingAnchor.constraint(equalTo: view.title.trailingAnchor),
            view.favouriteButton.trailingAnchor.constraint(equalTo: view.imageView.trailingAnchor, constant: -Constants.smallPadding),
            view.favouriteButton.heightAnchor.constraint(equalToConstant: Constants.starIconSize),
            view.favouriteButton.widthAnchor.constraint(equalToConstant: Constants.starIconSize),
            
            view.releaseDate.topAnchor.constraint(equalTo: view.title.bottomAnchor, constant: Constants.smallPadding),
            view.releaseDate.leadingAnchor.constraint(equalTo: view.imageView.leadingAnchor),
            view.releaseDate.trailingAnchor.constraint(equalTo: view.imageView.trailingAnchor),
            
            view.rating.topAnchor.constraint(equalTo: view.releaseDate.bottomAnchor),
            view.rating.leadingAnchor.constraint(equalTo: view.imageView.leadingAnchor),
            view.rating.trailingAnchor.constraint(equalTo: view.imageView.trailingAnchor),
            
            view.overview.topAnchor.constraint(equalTo: view.rating.bottomAnchor, constant: Constants.smallPadding),
            view.overview.leadingAnchor.constraint(equalTo: view.imageView.leadingAnchor),
            view.overview.trailingAnchor.constraint(equalTo: view.imageView.trailingAnchor),
            view.overview.bottomAnchor.constraint(equalTo: view.scrollView.bottomAnchor, constant: -Constants.bigPadding),
        ])
    }
    
    private struct Constants {
        static let smallPadding: CGFloat = 10.0
        static let bigPadding: CGFloat = 30.0
        static let imageSize: CGFloat = 300.0
        static let starIconSize: CGFloat = 35.0
    }
}

extension MovieDetailsLayoutManager: MovieDetailsLayoutManaging {
    func layout(view: MovieDetailsViewInterface) {
        setupHierarchy(in: view)
        setupConstraints(in: view)
    }
}
