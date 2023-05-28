//
//  ImageEndpointMock.swift
//  ShowtimeNowTests
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

@testable import ShowtimeNow

final class ImageEndpointMock {
    var mock: String = ""
}

extension ImageEndpointMock: ImageProviding {
    func getImagePath(from url: String) -> String {
        mock
    }
}
