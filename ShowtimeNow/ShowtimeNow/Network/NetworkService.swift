//
//  NetworkService.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import Foundation

final class NetworkService {
    enum Error: Swift.Error {
        case invalidData(error: Swift.Error)
        case invalidResponse
        case invalidUrl
        case emptyResponse
    }
    
    private let session: NetworkSession
    private let config: NetworkConfig

    init(
        session: NetworkSession = URLSession.shared,
        config: NetworkConfig
    ) {
        self.session = session
        self.config = config
    }
    
    private func urlRequest(with path: String, params: [String: String]?) -> URLRequest? {
        let url = URL(string: config.baseURL.absoluteString + path)
        guard let url = url, var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil //invalid endpoint
        }
        
        // TMP:
        let apiKey = "cab596273745de3bac5ce9cc9adf5f60"
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        guard let finaUrl = urlComponents.url else {
            return nil //invalid Url
        }

        
        return URLRequest(url: finaUrl)
    }
}

extension NetworkService: NetworkServiceProviding {
    func requestData(with path: String, params: [String: String]? = nil, completion: @escaping (Result<Data, Swift.Error>) -> Void) {
        guard let request = self.urlRequest(with: path, params: params) else {
            completion(.failure(Error.invalidUrl))
            return
        }

        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(Error.invalidData(error: error)))
                    return
                }

                guard
                    let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode)
                else {
                    completion(.failure(Error.invalidResponse))
                    return
                }

                guard let data = data else {
                    completion(.failure(Error.emptyResponse))
                    return
                }

                completion(.success(data))
            }
        }.resume()
    }
}
