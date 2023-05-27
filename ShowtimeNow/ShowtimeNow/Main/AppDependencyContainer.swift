//
//  AppDependencyContainer.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import Foundation

final class AppDependencyContainer {
    lazy var appConfiguration = AppConfiguration()
    
    private func makeNetworkService() -> NetworkService? {
        guard let url = URL(string: appConfiguration.baseURL) else {
            return nil
        }
        let configuration = ApiDataNetworkConfig(
            baseURL: url
        )
        return NetworkService(config: configuration)
    }
    
    private func makeMoviesController() -> MoviesNavigationController {
        let listViewController = makeMovieListViewController()
        return MoviesNavigationController(listViewController: listViewController)
    }
    
    private func makeMovieListViewController() -> MovieListViewController {
        let networkService = makeNetworkService()
        
        let viewControllerFactory = MovieListViewControllerFactory(
            networkService: networkService
        )
        return viewControllerFactory.configure()
    }
    
    private func makeMovieDetailViewController() {} // TODO:
    
    func makeMainViewController() -> MainViewController {
        let moviesViewController = makeMoviesController()
        return MainViewController(viewController: moviesViewController)
    }
}

