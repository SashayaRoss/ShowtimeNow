//
//  ApiDataNetworkConfig.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import Foundation

struct ApiDataNetworkConfig: NetworkConfig {
    let baseURL: URL
    let headers: [String: String]
    let queryParameters: [String: String]

    init(
        baseURL: URL,
        headers: [String: String] = [:],
        queryParameters: [String: String] = [:])
    {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
