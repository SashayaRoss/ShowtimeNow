//
//  MovieLoading.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

protocol MoviesLoading {
    func getMovies(completion: @escaping (Result<MoviesEntity, Error>) -> Void)
}
