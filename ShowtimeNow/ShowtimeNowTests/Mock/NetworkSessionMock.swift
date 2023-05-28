//
//  NetworkSessionMock.swift
//  ShowtimeNowTests
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

import Foundation
@testable import ShowtimeNow

final class NetworkSessionMock {
    var urlRequest: URLRequest?
    var data: Data?
    var error: Error?
    var urlResponse: URLResponse?
}

extension NetworkSessionMock: NetworkSession {
    func dataTask(with url: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        urlRequest = url
        let data = self.data
        let error = self.error
        let urlResponse = self.urlResponse

        return MockDataTask {
            completionHandler(data, urlResponse, error)
        }
    }
}
