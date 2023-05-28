//
//  ImageRepositoryTests.swift
//  ShowtimeNowTests
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

import Foundation
import XCTest
@testable import ShowtimeNow

final class ImageRepositoryTests: XCTestCase {
    private var networkService: NetworkServiceMock?
    private var endpoint: ImageEndpointMock?
    private var cache = NSCache<NSString, ImageEntity>()
    private var sut: ImageRepository?
    
    override func setUp() {
        super.setUp()
        let networkService = NetworkServiceMock()
        let endpoint = ImageEndpointMock()
        
        self.networkService = networkService
        self.endpoint = endpoint
            
        sut = ImageRepository(
            networkService: networkService,
            endpoint: endpoint,
            cache: cache
        )
    }
    
    override func tearDown() {
        networkService = nil
        endpoint = nil
        sut = nil
        cache.removeAllObjects()
        
        super.tearDown()
    }
    
    private func createMockImage() -> Data? {
        let size = CGSize(width: 1, height: 1)
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let image =  UIGraphicsImageRenderer(size: size, format: format).image { rendererContext in
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
        return image.pngData()
    }
    
    func testSuccessfulGettingMovies() throws {
        let networkService = try XCTUnwrap(self.networkService)
        let sut = try XCTUnwrap(self.sut)
        
        guard let mockImage = createMockImage() else {
            XCTFail("Image mock doesn't exist.")
            return
        }

        let networkServiceExpectation = self.expectation(description: "NetworkService must be called")
        networkService.getDataBlock = { _, _, completion in
            networkServiceExpectation.fulfill()
            completion(.success(mockImage))
        }
        
        let thumbnailMock = "MOCK_PATH"
        let getImageExpectation = self.expectation(description: "Get Image must be called.")
        sut.getImage(with: thumbnailMock, size: 185) { result in
            switch result {
            case let .failure(error):
                XCTFail("Unexpected error occured: \(error)")
            case let .success(image):
                XCTAssertNotNil(image)
            }
            getImageExpectation.fulfill()
        }
        waitForExpectations(timeout: 0.1)
    }
    
    func testServiceError() throws {
        let networkService = try XCTUnwrap(self.networkService)
        let sut = try XCTUnwrap(self.sut)
        let error = NSError(domain: "", code: 1, userInfo: nil)

        let networkServiceExpectation = self.expectation(description: "NetworkService must be called.")
        networkService.getDataBlock = { _, _, completion in
            networkServiceExpectation.fulfill()
            completion(.failure(error))
        }
        
        let getImageExpectation = self.expectation(description: "Get image must fail.")
        let thumbnailMock = "MOCK_PATH"
        sut.getImage(with: thumbnailMock, size: 185) { result in
            switch result {
            case let .failure(error):
                XCTAssertNotNil(error)
                getImageExpectation.fulfill()
            case .success(_):
                XCTFail("Get image should fail.")
            }
        }
        waitForExpectations(timeout: 0.1)
    }
}

