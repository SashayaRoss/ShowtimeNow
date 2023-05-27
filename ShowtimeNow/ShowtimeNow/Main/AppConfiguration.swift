//
//  AppConfiguration.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import Foundation

final class AppConfiguration {
    lazy var baseURL: String = {
        return "https://api.themoviedb.org/3"
    }()
}
