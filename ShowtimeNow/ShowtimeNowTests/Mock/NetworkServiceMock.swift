//
//  NetworkServiceMock.swift
//  ShowtimeNowTests
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

import Foundation
@testable import ShowtimeNow

final class NetworkServiceMock {
    var getDataBlock: ((String, [String : String]?, @escaping (Result<Data, Error>) -> Void) -> Void)?
}

extension NetworkServiceMock: NetworkServiceProviding {
    func requestData(with endpointPath: String, params: [String : String]?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let block = getDataBlock else {
            return
        }
        block(endpointPath, params, completion)
    }
}
