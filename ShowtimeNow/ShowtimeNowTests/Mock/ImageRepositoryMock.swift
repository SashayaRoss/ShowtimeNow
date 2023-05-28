//
//  ImageRepositoryMock.swift
//  ShowtimeNowTests
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

import UIKit
@testable import ShowtimeNow

final class ImageRepositoryMock {}

extension ImageRepositoryMock: ImageLoading {
    func getImage(with imagePath: String, size: Int, completion: @escaping (Result<UIImage, Error>) -> Void) {
        completion(.success(UIImage()))
    }
}
