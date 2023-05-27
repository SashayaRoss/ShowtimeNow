//
//  MoviesViewState.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

enum MoviesViewState {
    case list
    case detail(movie: MovieEntity)
    case search
}
