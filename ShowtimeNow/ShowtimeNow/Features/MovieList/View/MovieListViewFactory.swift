//
//  MovieListViewFactory.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

final class MovieListViewFactory {
    private let appearanceManager: MovieListAppearanceManaging
    private let layoutManager: MovieListLayoutManaging
    
    init(
        appearanceManager: MovieListAppearanceManaging,
        layoutManager: MovieListLayoutManaging
    ) {
        self.appearanceManager = appearanceManager
        self.layoutManager = layoutManager
    }
}

extension MovieListViewFactory: MovieListViewProducing {
    func make() -> MovieListViewInterface {
        let view = MovieListView()
        layoutManager.layout(view: view)
        appearanceManager.decorate(view: view)

        return view
    }
}
