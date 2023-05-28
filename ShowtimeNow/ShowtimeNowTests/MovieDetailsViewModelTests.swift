//
//  MovieDetailsViewModelTests.swift
//  ShowtimeNowTests
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

import XCTest
@testable import ShowtimeNow

final class MovieDetailsViewModelTests: XCTestCase {
    private var sut: MovieDetailsViewModel?
    
    override func setUp() {
        super.setUp()
        let movie = createMovies()
        sut = MovieDetailsViewModel(
            movie: movie,
            imageRepository: ImageRepositoryMock())
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    private func createMovies() -> MovieEntity {
        return MovieEntity(
            id: 123,
            title: "TITLE",
            backdrop_path: "BACKDROP_PATH",
            poster_path: "POSTER_PATH",
            overview: "OVERVIEW",
            release_date: "2020-01-01",
            vote_average: 6.6)
    }
    
    func testTitle() throws {
        let sut = try XCTUnwrap(self.sut)
        XCTAssertEqual(sut.title, "TITLE")
    }
    
    func testOverview() throws {
        let sut = try XCTUnwrap(self.sut)
        XCTAssertEqual(sut.description, "OVERVIEW")
    }
    
    func testReleaseDate() throws {
        let sut = try XCTUnwrap(self.sut)
        XCTAssertEqual(sut.releaseDate, "Release date: 1 January 2020")
    }
    
    func testVoteAverage() throws {
        let sut = try XCTUnwrap(self.sut)
        XCTAssertEqual(sut.rating, "Rating: 6.6 / 10")
    }
}
