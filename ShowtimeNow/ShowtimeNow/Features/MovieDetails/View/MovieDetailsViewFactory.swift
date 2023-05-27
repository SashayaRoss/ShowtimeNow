//
//  MovieDetailsViewFactory.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

final class MovieDetailsViewFactory {}

extension MovieDetailsViewFactory: MovieDetailsViewProducing {
    func make() -> MovieDetailsViewInterface {
        let view = MovieDetailsView()
        view.backgroundColor = .darkBlue()
        return view
    }
}
