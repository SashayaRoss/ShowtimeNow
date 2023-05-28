//
//  MovieDetaislViewModel.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

final class MovieDetailsViewModel {
    private let movie: MovieEntity
    private let imageRepository: ImageLoading
    
    var title: String {
        movie.title
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
    
    func getImage(completion: @escaping (UIImage?) -> Void) {
        guard let posterPath = movie.poster_path else {
            completion(nil)
            return
        }
        imageRepository.getImage(with: posterPath, size: Constants.size) { result in
            switch result {
            case let .success(image):
                completion(image)
            case .failure:
                completion(nil)
            }
        }
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

    init(movie: MovieEntity, imageRepository: ImageLoading) {
        self.movie = movie
        self.imageRepository = imageRepository
    }
    
    private struct Constants {
        static let size: Int = 150
    }
}
