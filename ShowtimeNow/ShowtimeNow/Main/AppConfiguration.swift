//
//  AppConfiguration.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import Foundation

struct AppConfiguration {
    lazy var baseURL: String = {
        "https://api.themoviedb.org/3"
    }()
    
    lazy var imageURL: String = {
        "https://image.tmdb.org/t/p/w500"
    }()
}
