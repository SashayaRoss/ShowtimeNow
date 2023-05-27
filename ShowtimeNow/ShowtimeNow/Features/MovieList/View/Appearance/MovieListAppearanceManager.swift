//
//  MovieListAppearanceManager.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

final class ListAppearanceManager {}

extension ListAppearanceManager: MovieListAppearanceManaging {
    func decorate(view: MovieListViewInterface) {
        view.backgroundColor = .white
        
        view.collectionView.backgroundColor = .clear
        view.collectionView.showsVerticalScrollIndicator = false
        
        view.activityIndicator.color = .white
    }
}
