//
//  MovieListLayoutManager.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

final class MovieListLayoutManager {
    private func setupHierarchy(in view: MovieListViewInterface) {
        view.addSubview(view.collectionView)
        view.addSubview(view.activityIndicator)
    }
    
    private func setupConstraints(in view: MovieListViewInterface) {
        view.collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            view.collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
            view.collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10.0),
            view.collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10.0),
            
            view.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension MovieListLayoutManager: MovieListLayoutManaging {
    func layout(view: MovieListViewInterface) {
        setupHierarchy(in: view)
        setupConstraints(in: view)
    }
}
