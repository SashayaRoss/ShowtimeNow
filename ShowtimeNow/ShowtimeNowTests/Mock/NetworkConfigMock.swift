//
//  NetworkConfigMock.swift
//  ShowtimeNowTests
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

import Foundation
@testable import ShowtimeNow

final class NetworkConfigMock: NetworkConfig {
    var baseURL: URL
    var headers: [String : String]
    var queryParameters: [String : String]
    
    init(
        baseURL: URL,
        headers: [String: String] = [:],
        queryParameters: [String: String] = [:]
    ) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
