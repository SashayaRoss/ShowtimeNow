//
//  MovieListCellViewModel.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

final class MovieListCellViewModel: MovieListItemProtocol {
    private let movie: Movie

    var title: String {
        movie.title
    }

    init(movie: Movie) {
        self.movie = movie
    }
}
