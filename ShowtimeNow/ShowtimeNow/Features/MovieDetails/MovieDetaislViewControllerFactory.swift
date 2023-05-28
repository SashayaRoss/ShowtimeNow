//
//  MovieDetaislViewControllerFactory.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

final class MovieDetailsViewControllerFactory {
    func configure(movie: MovieEntity, imageRepository: ImageRepository) -> MovieDetailsViewController {
        let viewModel = MovieDetailsViewModel(
            movie: movie,
            imageRepository: imageRepository
        )
        
        let appearanceManager = MovieDetailsAppearanceManager()
        let layoutManager = MovieDetailsLayoutManager()
        
        let viewFactory = MovieDetailsViewFactory(
            appearanceManager: appearanceManager,
            layoutManager: layoutManager
        )
        
        return MovieDetailsViewController(
            viewFactory: viewFactory,
            viewModel: viewModel
        )
    }
}
