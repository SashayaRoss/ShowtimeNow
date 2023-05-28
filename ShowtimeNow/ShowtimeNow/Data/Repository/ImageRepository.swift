//
//  ImageRepository.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

import UIKit

final class ImageRepository {
    enum Error: Swift.Error {
        case networkServiceUnavailable
        case invalidResponse(error: Swift.Error)
        case invalidData
        case selfDeallocated
    }
    
    private let networkService: NetworkServiceProviding?
    private let endpoint: ImageProviding
    private let cache: NSCache<NSString, ImageEntity>

    init(
        networkService: NetworkServiceProviding?,
        endpoint: ImageProviding,
        cache: NSCache<NSString, ImageEntity>
    ) {
        self.networkService = networkService
        self.endpoint = endpoint
        self.cache = cache
    }
}

extension ImageRepository: ImageLoading {
    func getImage(with imagePath: String, size: Int, completion: @escaping (Result<UIImage, Swift.Error>) -> Void) {
        if
            let cachedImage = cache.object(forKey: imagePath as NSString),
            cachedImage.size == size
        {
            completion(.success(cachedImage.image))
            return
        }

        guard let network = networkService else {
            completion(.failure(Error.networkServiceUnavailable))
            return
        }
        let imageEndpoint = endpoint.getImagePath(from: imagePath)

        network.requestData(with: imageEndpoint, params: [:]) { [weak self] result in
            guard
                let strongSelf = self
            else {
                completion(.failure(Error.selfDeallocated))
                return
            }
            switch result {
            case let .success(data):
                guard
                    let image = UIImage(data: data)
                else {
                    completion(.failure(Error.invalidData))
                    return
                }
                let object = ImageEntity(image: image, size: size)
                strongSelf.cache.setObject(object, forKey: imagePath as NSString)
                completion(.success(image))
            case let .failure(error):
                completion(.failure(Error.invalidResponse(error: error)))
            }
        }
    }
}
