//
//  MovieDetaislViewModel.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

final class MovieDetailsViewModel {
    private let movie: MovieEntity
    
    var title: String {
        return movie.title
    }

    init(movie: MovieEntity) {
        self.movie = movie
    }
}
