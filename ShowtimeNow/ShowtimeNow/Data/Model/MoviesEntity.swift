//
//  MovieEntity.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import Foundation

struct MoviesEntity: Decodable {
    let results: [Movie]
}

struct Movie: Decodable { // fix name
    let id: Int
    let title: String
    let adult: Bool
//    let backdropPath: String?
//    let posterPath: String?
    let overview: String?
//    let releaseDate: String?
//    let voteAverage: Double
//    let voteCount: Int
}
