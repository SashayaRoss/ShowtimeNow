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
        "Release date: \(String.formattedDate(string: movie.release_date ?? "N/A"))"
    }
    
    var description: String {
        movie.overview ?? "N/A"
    }
    
    var rating: String {
        "Rating: \(String(format: "%.1f", movie.vote_average ?? 0)) / 10"
    }
    
    var overview: String {
        movie.overview ?? "N/A"
    }
    
    var favouriteButtonImage: UIImage? = UIImage(systemName: "star")
    
    var isFavourite: Bool = false {
        didSet {
            let image = isFavourite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            favouriteButtonImage = image
        }
    }
    
    func updateFavouriteButton() {
        isFavourite = isFavourite ? false : true
    }

    init(movie: MovieEntity) {
        self.movie = movie
    }
}
