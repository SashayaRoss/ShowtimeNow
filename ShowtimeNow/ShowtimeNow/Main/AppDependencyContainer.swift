//
//  AppDependencyContainer.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

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
            baseURL: url,
            queryParameters: [:]
        )
        return NetworkService(config: configuration)
    }
    
    private func makeNetworkServiceForImages() -> NetworkService? {
        guard let url = URL(string: appConfiguration.imageURL) else {
            return nil
        }
        let configuration = ApiDataNetworkConfig(
            baseURL: url
        )
        return NetworkService(config: configuration)
    }
    
    private func makeMoviesController() -> MoviesNavigationController {
        let networkService = makeNetworkService()
        
        let listViewController = makeMovieListViewController(networkService: networkService)
        let detailsViewController = makeMovieDetailViewController
        let searchViewController = makeSearchViewController(networkService: networkService)
        
        return MoviesNavigationController(
            viewModel: viewModel,
            listViewController: listViewController,
            detailsViewController: detailsViewController,
            searchViewController: searchViewController
        )
    }
    
    private func makeMovieListViewController(networkService: NetworkService?) -> MovieListViewController {
        let imageEndpoint = ImageEndpoint()
        let cache = NSCache<NSString, ImageEntity>()
        let imageRepository = ImageRepository(
            networkService: makeNetworkServiceForImages(),
            endpoint: imageEndpoint,
            cache: cache
        )
        
        let cellViewModelFactory = { (movie: MovieEntity) in
            return self.makeMovieListCellViewModel(
                movie: movie,
                imageRepository: imageRepository
            )
        }
        
        let viewControllerFactory = MovieListViewControllerFactory(
            networkService: networkService,
            responder: viewModel,
            cellViewModelFactory: cellViewModelFactory
        )
        return viewControllerFactory.configure()
    }
    
    private func makeMovieListCellViewModel(movie: MovieEntity, imageRepository: ImageLoading) -> MovieListCellViewModel {
        MovieListCellViewModel(movie: movie, imageRepository: imageRepository)
    }
    
    private func makeSearchCellViewModel(movie: MovieEntity, imageRepository: ImageLoading) -> SearchResultsTableViewCellViewModel {
        SearchResultsTableViewCellViewModel(movie: movie, imageRepository: imageRepository)
    }
    
    private func makeMovieDetailViewController(with movie: MovieEntity) -> MovieDetailsViewController {
        let imageEndpoint = ImageEndpoint()
        let cache = NSCache<NSString, ImageEntity>()
        let imageRepository = ImageRepository(
            networkService: makeNetworkServiceForImages(),
            endpoint: imageEndpoint,
            cache: cache
        )
        let viewControllerFactory = MovieDetailsViewControllerFactory()
        return viewControllerFactory.configure(
            movie: movie,
            imageRepository: imageRepository
        )
    }
    
    private func makeSearchViewController(networkService: NetworkService?) -> SearchViewController {
        let searchResultsController = makeSearchResultsController()
        let endpoint = SearchEndpoint()
        let repository = SearchRepository(
            networkService: networkService,
            endpoint: endpoint
        )
        return SearchViewController(
            repository: repository,
            searchResultsController: searchResultsController
        )
    }
    
    private func makeSearchResultsController() -> UISearchController {
        let viewFactory = SearchViewFactory(
            appearanceManager: SearchAppearanceManager(),
            layoutManager: SearchLayoutManager()
        )
        
        let imageEndpoint = ImageEndpoint()
        let cache = NSCache<NSString, ImageEntity>()
        let imageRepository = ImageRepository(
            networkService: makeNetworkServiceForImages(),
            endpoint: imageEndpoint,
            cache: cache
        )
        
        let cellViewModelFactory = { (movie: MovieEntity) in
            return self.makeSearchCellViewModel(
                movie: movie,
                imageRepository: imageRepository
            )
        }
        
        let searchResultsController = SearchResultsViewController(
            viewFactory: viewFactory,
            cellViewModelFactory: cellViewModelFactory
        )
        return UISearchController(searchResultsController: searchResultsController)
    }
    
    func makeMainViewController() -> MainViewController {
        let moviesViewController = makeMoviesController()
        return MainViewController(viewController: moviesViewController)
    }
}

