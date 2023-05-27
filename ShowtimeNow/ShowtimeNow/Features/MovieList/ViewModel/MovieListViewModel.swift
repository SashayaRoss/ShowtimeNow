//
//  MovieListViewModel.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import Foundation

final class MovieListViewModel {
    private let moviesRepository: MoviesLoading
    private let moviesResponder: MoviesResponder
    private var movies: [MovieEntity] = []
    var viewState: DynamicType<ListViewState> = DynamicType<ListViewState>()
    
    init(
        moviesRepository: MoviesLoading,
        moviesResponder: MoviesResponder
    ) {
        self.moviesRepository = moviesRepository
        self.moviesResponder = moviesResponder
    }
    
    var numberOfMovies: Int {
        return movies.count
    }
    
    func loadMovies() {
        viewState.value = .loading
        moviesRepository.getMovies { [weak self] movieResult in
            guard
                let strongSelf = self
            else {
                return
            }
            
            switch movieResult {
            case let .success(movies):
                strongSelf.movies = movies.results
                strongSelf.viewState.value = .finishedLoading
            case let .failure(error):
                strongSelf.viewState.value = .error(error: error)
            }
        }
    }
    
    func movie(for indexPath: IndexPath) -> MovieEntity {
        movies[indexPath.row]
    }
    
    func showDetails(movie: MovieEntity) {
        moviesResponder.showDetail(movie: movie)
    }
    
    func showSearch() {
        moviesResponder.showSearch()
    }
}
