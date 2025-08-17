//
//  SearchForQuoteTests.swift
//  QuoteAppTests
//
//  Created by David on 16/08/2025.
//

import XCTest

final class SearchForQuoteTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchForQuoteInSuccess() throws {
        // Given
        let repository = InMemoryQuoteRepository(
            url: Bundle(for: type(of: self)).url(forResource: "list-of-10-quotes-with-explicit-text-for-search", withExtension: "json")!
        )
        let searchForQuotes = SearchForQuotes(quoteRepository: repository)

        // When
        let quotes = try searchForQuotes.execute(withString: "aaa")

        // Then
        XCTAssert(quotes.count == 1, "Should have one result with the 'aaa' search string")
    }

    func testSearchForQuoteInFail() throws {
        // Given
        let repository = InMemoryQuoteRepository(
            url: Bundle(for: type(of: self)).url(forResource: "list-of-10-quotes-with-explicit-text-for-search", withExtension: "json")!
        )
        let searchForQuotes = SearchForQuotes(quoteRepository: repository)

        // When
        let quotes = try searchForQuotes.execute(withString: "aaaa")

        // Then
        XCTAssert(quotes.count == 0, "Should *NOT* find quote with 'aaaa' in the text")
    }

    func testSearchForQuoteAndFindTwoOccurrencesInSuccess() throws {
        // Given
        let repository = InMemoryQuoteRepository(
            url: Bundle(for: type(of: self)).url(forResource: "list-of-10-quotes-with-explicit-text-for-search", withExtension: "json")!
        )
        let searchForQuotes = SearchForQuotes(quoteRepository: repository)

        // When
        let quotes = try searchForQuotes.execute(withString: "foo")

        // Then
        XCTAssert(quotes.count == 2, "Should find 2 occurrences with the 'foo' search string")
        XCTAssert(quotes[0].id == 9, "First occurrence should be id=9")
        XCTAssert(quotes[1].id == 10, "Second occurrence should be id=10")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
