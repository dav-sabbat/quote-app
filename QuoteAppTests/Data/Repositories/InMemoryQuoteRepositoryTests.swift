//
//  InMemoryQuoteRepositoryTests.swift
//  QuoteAppTests
//
//  Created by David on 13/08/2025.
//

import XCTest

final class InMemoryQuoteRepositoryTests: XCTestCase {
    let dataResource = "list-of-random-26-quotes"
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testfetchAllQuotesInSuccess() throws {
        // Given
        let repo = InMemoryQuoteRepository(
            url: Bundle(for: type(of: self)).url(forResource: dataResource, withExtension: "json")!
        )

        // When
        let quotes = try repo.fetchAll()

        // Then
        XCTAssert(quotes.count == 26, "Make sure it retrieves 26 quotes from a data file")
        XCTAssert(quotes.first!.author == "Albert Einstein", "Make sure the first quote of the list of from Albert Einstein")
    }
    
    func testfetchAllFavoriteQuotesInSuccess() throws {
        // Given
        let repo = InMemoryQuoteRepository(
            url: Bundle(for: type(of: self)).url(forResource: dataResource, withExtension: "json")!
        )

        // When
        let quotes = try repo.fetchAllFavoriteQuotes()

        // Then
        XCTAssert(quotes.count == 13, "Make sure it retrieves 13 favorite quotes from a data file")
        XCTAssert(quotes.first!.id == 1, "Make sure the first favorite quote of the file is id=1")
        XCTAssert(quotes.first!.isFavorite == true, "Make sure the first favorite quote has the prop isFavorite set to true")
        XCTAssert(quotes.last!.id == 25, "Make sure the last favorite quote of the file is id=25")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
