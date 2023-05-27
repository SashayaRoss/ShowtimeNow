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
    
    func showDetail(movie: Movie) {
        viewState.value = .detail(movie: movie)
    }
}
