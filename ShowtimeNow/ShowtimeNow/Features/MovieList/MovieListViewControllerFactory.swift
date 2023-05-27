//
//  MovieListViewControllerFactory.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

final class MovieListViewControllerFactory {
    private let networkService: NetworkServiceProviding?
    private let responder: MoviesResponder
    private let cellViewModelFactory: (_ movie: MovieEntity) -> MovieListCellViewModel
    
    init(
        networkService: NetworkServiceProviding?,
        responder: MoviesResponder,
        cellViewModelFactory: @escaping (_ movie: MovieEntity) -> MovieListCellViewModel
    ) {
        self.networkService = networkService
        self.responder = responder
        self.cellViewModelFactory = cellViewModelFactory
    }

    func configure() -> MovieListViewController {
        let endpoint = MoviesEndpoint()
        let repository = MoviesRepository(
            networkService: networkService,
            endpoint: endpoint
        )

        let viewModel = MovieListViewModel(
            moviesRepository: repository,
            moviesResponder: responder
        )
        
        let appearanceManager = ListAppearanceManager()
        let layoutManager = MovieListLayoutManager()
        
        let viewFactory = MovieListViewFactory(
            appearanceManager: appearanceManager,
            layoutManager: layoutManager
        )
        
        let viewController = MovieListViewController(
            viewModel: viewModel,
            viewFactory: viewFactory,
            cellViewModelFactory: cellViewModelFactory
        )
        
        return viewController
    }
}
