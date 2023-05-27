//
//  MoviesRepository.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import Foundation

final class MoviesRepository {
    enum Error: Swift.Error {
        case networkServiceUnavailable
        case invalidResponse(error: Swift.Error)
        case invalidData(error: Swift.Error)
    }
    
    private let networkService: NetworkServiceProviding?
    private let endpoint: MoviesProviding

    init(
        networkService: NetworkServiceProviding?,
        endpoint: MoviesProviding
    ) {
        self.networkService = networkService
        self.endpoint = endpoint
    }
}

extension MoviesRepository: MoviesLoading {
    func getMovies(completion: @escaping (Result<[MovieEntity], Swift.Error>) -> Void) {
        let moviesEndpoint = endpoint.getMoviesPath()
        
        guard let network = networkService else {
            completion(.failure(Error.networkServiceUnavailable))
            return
        }
        
        network.requestData(with: moviesEndpoint, params: [:]) { result in
            switch result {
            case let .success(data):
                do {
//                    let decoder = JSONDecoder()
//                    let movies = try decoder.decode([MovieEntity].self, from: data)
//                    completion(.success(movies))
                    
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(result)
                    completion(.success([]))
                } catch let error {
                    completion(.failure(Error.invalidData(error: error)))
                }
            case let .failure(error):
                completion(.failure(Error.invalidResponse(error: error)))
            }
        }
    }
}
