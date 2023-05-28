//
//  SearchRepositoryTests.swift
//  ShowtimeNowTests
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

import Foundation
import XCTest
@testable import ShowtimeNow

final class SearchRepositoryTests: XCTestCase {
    private var networkService: NetworkServiceMock?
    private var endpoint: SearchEndpointMock?
    private var sut: SearchRepository?
    
    override func setUp() {
        super.setUp()
        let networkService = NetworkServiceMock()
        let endpoint = SearchEndpointMock()
        
        self.networkService = networkService
        self.endpoint = endpoint
            
        sut = SearchRepository(
            networkService: networkService,
            endpoint: endpoint)
    }
    
    override func tearDown() {
        networkService = nil
        endpoint = nil
        sut = nil
        
        super.tearDown()
    }
    
    func testSuccessfulSearch() throws {
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
        
        let searchExpectation = self.expectation(description: "Search must succeed")
        let query = ""
        sut.search(with: query) { result in
            switch result {
            case let .failure(error):
                XCTFail("Unexpected error occured: \(error)")
            case let .success(movies):
                searchExpectation.fulfill()
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
        
        let searchExpectation = self.expectation(description: "Search must fail.")
        let query = ""
        sut.search(with: query) { result in
            switch result {
            case let .failure(error):
                XCTAssertNotNil(error)
                searchExpectation.fulfill()
            case .success(_):
                XCTFail("Search should fail.")
            }
        }
        waitForExpectations(timeout: 0.1)
    }
}
