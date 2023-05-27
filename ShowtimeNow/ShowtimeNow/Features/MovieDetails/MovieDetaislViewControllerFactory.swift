//
//  MovieDetaislViewControllerFactory.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

final class MovieDetailsViewControllerFactory {
    func configure(movie: MovieEntity) -> MovieDetailsViewController {
        let viewModel = MovieDetailsViewModel(movie: movie)
        let viewFactory = MovieDetailsViewFactory()
        
        return MovieDetailsViewController(
            viewFactory: viewFactory,
            viewModel: viewModel
        )
    }
}

