//
//  MovieListViewState.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

enum ListViewState {
    case loading
    case finishedLoading
    case error(error: Error)
}
