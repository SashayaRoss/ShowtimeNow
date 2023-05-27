//
//  AppDependencyContainer.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import Foundation

final class AppDependencyContainer {
    let viewModel: MainViewModel
    lazy var appConfiguration = AppConfiguration()
    
    init() {
        viewModel = MainViewModel()
    }
    
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
        
        return MoviesNavigationController(viewModel: viewModel, listViewController: listViewController)
    }
    
    private func makeMovieListViewController() -> MovieListViewController {
        let networkService = makeNetworkService()
        
        let cellViewModelFactory = { (movie: Movie) in
            return self.makeMovieListCellViewModel(
                movie: movie
            )
        }
        
        let viewControllerFactory = MovieListViewControllerFactory(
            networkService: networkService,
            responder: viewModel,
            cellViewModelFactory: cellViewModelFactory
        )
        return viewControllerFactory.configure()
    }
    
    private func makeMovieListCellViewModel(movie: Movie) -> MovieListCellViewModel {
        return MovieListCellViewModel(movie: movie)
    }
    
    private func makeMovieDetailViewController() {} // TODO:
    
    func makeMainViewController() -> MainViewController {
        let moviesViewController = makeMoviesController()
        return MainViewController(viewController: moviesViewController)
    }
}

