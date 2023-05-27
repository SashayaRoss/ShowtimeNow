//
//  MovieDetailsLayoutManager.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

final class MovieDetailsLayoutManager {
    private func setupHierarchy(in view: MovieDetailsViewInterface) {
        view.addSubview(view.imageView)
        view.addSubview(view.title)
        view.addSubview(view.releaseDate)
        view.addSubview(view.overview)
        view.addSubview(view.rating)
    }
    
    private func setupConstraints(in view: MovieDetailsViewInterface) {
        view.imageView.translatesAutoresizingMaskIntoConstraints = false
        view.title.translatesAutoresizingMaskIntoConstraints = false
        view.releaseDate.translatesAutoresizingMaskIntoConstraints = false
        view.overview.translatesAutoresizingMaskIntoConstraints = false
        view.rating.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            view.imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
            view.imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10.0),

            view.title.topAnchor.constraint(equalTo: view.imageView.bottomAnchor, constant: 10.0),
            view.title.leadingAnchor.constraint(equalTo: view.imageView.leadingAnchor),
            view.title.trailingAnchor.constraint(equalTo: view.imageView.trailingAnchor),
            
            view.releaseDate.topAnchor.constraint(equalTo: view.title.bottomAnchor, constant: 10.0),
            view.releaseDate.leadingAnchor.constraint(equalTo: view.imageView.leadingAnchor),
            view.releaseDate.trailingAnchor.constraint(equalTo: view.imageView.trailingAnchor),
            
            view.rating.topAnchor.constraint(equalTo: view.releaseDate.bottomAnchor, constant: 10.0),
            view.rating.leadingAnchor.constraint(equalTo: view.imageView.leadingAnchor),
            view.rating.trailingAnchor.constraint(equalTo: view.imageView.trailingAnchor),
            
            view.overview.topAnchor.constraint(equalTo: view.rating.bottomAnchor, constant: 10.0),
            view.overview.leadingAnchor.constraint(equalTo: view.imageView.leadingAnchor),
            view.overview.trailingAnchor.constraint(equalTo: view.imageView.trailingAnchor),
            view.overview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10.0),
        ])
    }
}

extension MovieDetailsLayoutManager: MovieDetailsLayoutManaging {
    func layout(view: MovieDetailsViewInterface) {
        setupHierarchy(in: view)
        setupConstraints(in: view)
    }
}
