//
//  MoviesEndpoint.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import Foundation

final class MoviesEndpoint: APIEndpoint {
    var path: String {
        return "/movie/now_playing"
    }
}

extension MoviesEndpoint: MoviesProviding {
    func getMoviesPath() -> String {
        return path
    }
}

