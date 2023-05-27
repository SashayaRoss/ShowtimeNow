//
//  MainViewModel.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

final class MainViewModel: MoviesResponder {
    var viewState: DynamicType<MoviesViewState> = DynamicType<MoviesViewState>()

    init() {
        viewState.value = .list
    }
    
    func showDetail(movie: MovieEntity) {
        viewState.value = .detail(movie: movie)
    }
    
    func showSearch() {
        viewState.value = .search
    }
}
