//
//  SearchLoading.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

protocol SearchLoading {
    func search(with querry: String, completion: @escaping (Result<MoviesEntity, Error>) -> Void)
}
