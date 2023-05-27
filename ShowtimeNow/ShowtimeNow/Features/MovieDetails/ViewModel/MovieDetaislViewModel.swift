//
//  MovieDetaislViewModel.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

final class MovieDetailsViewModel {
    private let movie: MovieEntity
    
//    var image: UIImage {
        //TODO:
//    }
    
    var title: String {
        return movie.title
    }
    
    var releaseDate: String {
        movie.release_date ?? "N/A" //
    }
    
    var description: String {
        movie.overview ?? "N/A" //
    }
    
    var rating: String {
        let votes = movie.vote_average ?? 0
        return String(format: "%.1f", votes)
    }
    
    var overview: String {
        movie.overview ?? "N/A"
    }

    init(movie: MovieEntity) {
        self.movie = movie
    }
}
