//
//  SearchRepository.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import Foundation

final class SearchRepository {
    enum Error: Swift.Error {
        case networkServiceUnavailable
        case invalidResponse(error: Swift.Error)
        case invalidData(error: Swift.Error)
    }
    
    private let networkService: NetworkServiceProviding?
    private let endpoint: SearchProviding

    init(
        networkService: NetworkServiceProviding?,
        endpoint: SearchProviding
    ) {
        self.networkService = networkService
        self.endpoint = endpoint
    }
}

extension SearchRepository: SearchLoading {
    func search(with querry: String, completion: @escaping (Result<MoviesEntity, Swift.Error>) -> Void) {
        let searchEndpoint = endpoint.getSearchPath()
        guard let network = networkService else {
            completion(.failure(Error.networkServiceUnavailable))
            return
        }
        let params = [
            "query": querry
        ]
        
        network.requestData(with: searchEndpoint, params: params) { result in
            switch result {
            case let .success(data):
                do {
                    let decoder = JSONDecoder()
                    let movies = try decoder.decode(MoviesEntity.self, from: data)
                    completion(.success(movies))
                } catch let error {
                    completion(.failure(Error.invalidData(error: error)))
                }
            case let .failure(error):
                completion(.failure(Error.invalidResponse(error: error)))
            }
        }
    }
}
