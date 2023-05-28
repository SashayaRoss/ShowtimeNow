//
//  SearchResultsTableViewCellViewModel.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

final class SearchResultsTableViewCellViewModel: MovieListItemProtocol {
    private let movie: MovieEntity
    private let imageRepository: ImageLoading

    var title: String {
        movie.title
    }

    init(movie: MovieEntity, imageRepository: ImageLoading) {
        self.movie = movie
        self.imageRepository = imageRepository
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
    
    private struct Constants {
        static let size: Int = 150
    }
}
