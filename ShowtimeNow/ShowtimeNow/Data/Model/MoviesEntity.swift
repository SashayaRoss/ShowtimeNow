//
//  MovieEntity.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import Foundation

struct MoviesEntity: Decodable {
    let results: [MovieEntity]
}

struct MovieEntity: Decodable {
    let id: Int
    let title: String
    let backdrop_path: String?
    let poster_path: String?
    let overview: String?
    let release_date: String?
    let vote_average: Double?
    // TODO: TMP
}
