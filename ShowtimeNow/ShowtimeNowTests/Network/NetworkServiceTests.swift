//
//  NetworkServiceTests.swift
//  ShowtimeNowTests
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

import XCTest
@testable import ShowtimeNow

final class NetworkServiceTests: XCTestCase {
    private var networkSession: NetworkSessionMock?
    private var networkConfig: NetworkConfigMock?
    private var sut: NetworkService?
    
    override func setUp() {
        super.setUp()
        let networkSession = NetworkSessionMock()
        
        guard let baseUrl = URL(string: "www.google.com") else {
            XCTFail("URL not valid.")
            return
        }
        let networkConfig = NetworkConfigMock(baseURL: baseUrl)
        
        self.networkSession = networkSession
        self.networkConfig = networkConfig
            
        sut = NetworkService(
            session: networkSession,
            config: networkConfig
        )
    }
    
    override func tearDown() {
        networkSession = nil
        networkConfig = nil
        sut = nil
        super.tearDown()
    }
    
    func testRequestForValidData() throws {
        let sut = try XCTUnwrap(self.sut)
        let networkSession = try XCTUnwrap(self.networkSession)
        let networkConfig = try XCTUnwrap(self.networkConfig)

        let mockResponseCode = 200
        let mockHttpResponse = HTTPURLResponse(
            url: networkConfig.baseURL,
            statusCode: mockResponseCode,
            httpVersion: nil,
            headerFields: nil
        )
        
        let expectedData = Data([0, 1])
        networkSession.data = expectedData
        networkSession.urlResponse = mockHttpResponse
        
        let expectation = self.expectation(description: "Should return data")
        let endpoint = "ENDPOINT"
        sut.requestData(with: endpoint) { result in
            switch result {
            case let .success(data):
                expectation.fulfill()
                XCTAssertEqual(data, expectedData)
            case let .failure(error):
                XCTFail("Unexpected error occured: \(error)")
            }
        }
        waitForExpectations(timeout: 0.1)
    }
    
    func testRequestResponseCode500() throws {
        let sut = try XCTUnwrap(self.sut)
        let networkSession = try XCTUnwrap(self.networkSession)
        let networkConfig = try XCTUnwrap(self.networkConfig)
        
        let mockResponseCode = 500
        let mockHttpResponse = HTTPURLResponse(
            url: networkConfig.baseURL,
            statusCode: mockResponseCode,
            httpVersion: nil,
            headerFields: nil
        )
        
        let expectedData = Data([0, 1])
        networkSession.data = expectedData
        networkSession.urlResponse = mockHttpResponse
        
        let expectation = self.expectation(description: "Should return data")
        let endpoint = "ENDPOINT"
        sut.requestData(with: endpoint) { result in
            switch result {
            case .success(_):
                XCTFail("Request should fail.")
            case let .failure(error):
                expectation.fulfill()
                XCTAssertNotNil(error)
            }
        }
        waitForExpectations(timeout: 0.1)
    }
    
    func testRequestNoValidData() throws {
        let sut = try XCTUnwrap(self.sut)
        
        let expectation = self.expectation(description: "Should return data")
        let endpoint = "ENDPOINT"
        sut.requestData(with: endpoint) { result in
            switch result {
            case .success(_):
                XCTFail("Request should fail.")
            case let .failure(error):
                expectation.fulfill()
                XCTAssertNotNil(error)
            }
        }
        waitForExpectations(timeout: 0.1)
    }
    
    func testRequestSessionError() throws {
        let sut = try XCTUnwrap(self.sut)
        let networkSession = try XCTUnwrap(self.networkSession)
        networkSession.error = NSError(domain: "", code: 1, userInfo: nil)
        
        let expectation = self.expectation(description: "Should return data")
        let endpoint = "ENDPOINT"
        sut.requestData(with: endpoint) { result in
            switch result {
            case .success(_):
                XCTFail("Request should fail.")
            case let .failure(error):
                expectation.fulfill()
                XCTAssertNotNil(error)
            }
        }
        waitForExpectations(timeout: 0.1)
    }
}

