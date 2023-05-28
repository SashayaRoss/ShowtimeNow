//
//  MoviesRepositoryTests.swift
//  ShowtimeNowTests
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

import Foundation
import XCTest
@testable import ShowtimeNow

final class MoviesRepositoryTests: XCTestCase {
    private var networkService: NetworkServiceMock?
    private var endpoint: MoviesEndpointMock?
    private var sut: MoviesRepository?
    
    override func setUp() {
        super.setUp()
        let networkService = NetworkServiceMock()
        let endpoint = MoviesEndpointMock()
        
        self.networkService = networkService
        self.endpoint = endpoint
            
        sut = MoviesRepository(
            networkService: networkService,
            endpoint: endpoint
        )
    }
    
    override func tearDown() {
        networkService = nil
        endpoint = nil
        sut = nil
        
        super.tearDown()
    }
    
    func testSuccessfulGettingMovies() throws {
        let networkService = try XCTUnwrap(self.networkService)
        let sut = try XCTUnwrap(self.sut)
        let movieResults = [
            "results" : []
        ]
        
        let jsonData = try JSONSerialization.data(withJSONObject: movieResults, options: JSONSerialization.WritingOptions.prettyPrinted)

        let networkServiceExpectation = self.expectation(description: "NetworkService must be called")
        networkService.getDataBlock = { _, _, completion in
            networkServiceExpectation.fulfill()
            completion(.success(jsonData))
        }
        
        let getMoviesExpectation = self.expectation(description: "Get movies must succeed")
        sut.getMovies { result in
            switch result {
            case let .failure(error):
                XCTFail("Unexpected error occured: \(error)")
            case let .success(movies):
                getMoviesExpectation.fulfill()
                XCTAssertNotNil(movies.results)
            }
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
        
        let getMoviesExpectation = self.expectation(description: "Get movies must fail.")
        sut.getMovies { result in
            switch result {
            case let .failure(error):
                XCTAssertNotNil(error)
                getMoviesExpectation.fulfill()
            case .success(_):
                XCTFail("Get movies should fail.")
            }
        }
        waitForExpectations(timeout: 0.1)
    }
}
