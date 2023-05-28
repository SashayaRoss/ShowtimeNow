//
//  MoviesEndpointMock.swift
//  ShowtimeNowTests
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

@testable import ShowtimeNow

final class MoviesEndpointMock {
    var mock: String = ""
}

extension MoviesEndpointMock: MoviesProviding {
    func getMoviesPath() -> String {
        mock
    }
}
