//
//  MovieDetailsViewFactory.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

final class MovieDetailsViewFactory {
    private let appearanceManager: MovieDetailsAppearanceManaging
    private let layoutManager: MovieDetailsLayoutManaging
    
    init(
        appearanceManager: MovieDetailsAppearanceManaging,
        layoutManager: MovieDetailsLayoutManaging
    ) {
        self.appearanceManager = appearanceManager
        self.layoutManager = layoutManager
    }
}

extension MovieDetailsViewFactory: MovieDetailsViewProducing {
    func make() -> MovieDetailsViewInterface {
        let view = MovieDetailsView()
        layoutManager.layout(view: view)
        appearanceManager.decorate(view: view)

        return view
    }
}
