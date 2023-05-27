//
//  NetworkServiceProviding.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import Foundation

protocol NetworkServiceProviding {
    func requestData(with endpointPath: String, completion: @escaping (Result<Data, Error>) -> Void)
}
