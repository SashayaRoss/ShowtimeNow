//
//  MovieEntity.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import Foundation

struct MovieEntity: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let adult: Bool
    let backdropPath: String?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    let voteAverage: Double
    let voteCount: Int
}
