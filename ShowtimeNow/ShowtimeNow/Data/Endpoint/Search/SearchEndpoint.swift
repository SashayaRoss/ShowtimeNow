//
//  SearchEndpoint.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import Foundation

final class SearchEndpoint: APIEndpoint {
    var path: String {
        return "/search/movie"
    }
}

extension SearchEndpoint: SearchProviding {
    func getSearchPath() -> String {
        return path
    }
}
