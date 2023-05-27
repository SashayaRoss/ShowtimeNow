//
//  MovieListViewControllerFactory.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

final class MovieListViewControllerFactory {
    private let networkService: NetworkServiceProviding?
    
    init(
        networkService: NetworkServiceProviding?
    ) {
        self.networkService = networkService
    }

    func configure() -> MovieListViewController {
        let endpoint = MoviesEndpoint()
        let repository = MoviesRepository(
            networkService: networkService,
            endpoint: endpoint
        )
        
//        move repository to viewModel
        let viewController = MovieListViewController(moviesRepository: repository)
        
        return viewController
    }
}

