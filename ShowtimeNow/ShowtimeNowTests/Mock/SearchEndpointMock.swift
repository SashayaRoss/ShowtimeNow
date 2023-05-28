//
//  SearchEndpointMock.swift
//  ShowtimeNowTests
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

@testable import ShowtimeNow

final class SearchEndpointMock {
    var mock: String = ""
}

extension SearchEndpointMock: SearchProviding {
    func getSearchPath() -> String {
        mock
    }
}
