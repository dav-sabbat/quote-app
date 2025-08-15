//
//  GetAllFavoriteQuotes.swift
//  QuoteAppTests
//
//  Created by David on 13/08/2025.
//

import XCTest

final class GetAllFavoriteQuotesTests: XCTestCase {
    let dataResource = "list-of-random-26-quotes"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExecuteReturnFavoriteQuotesInSuccess() throws {
        // Given
        let repository = InMemoryQuoteRepository(
            url: Bundle(for: type(of: self)).url(forResource: dataResource, withExtension: "json")!
        )
        let getAllFavoriteQuotes = GetAllFavoriteQuotes(quoteRepository: repository)

        // When
        let favoriteQuotes = try getAllFavoriteQuotes.execute()

        // Then
        XCTAssert(favoriteQuotes.count == 13, "Make sure we get only the favorite quote by counting the number of quote in the returned list")
        XCTAssert(favoriteQuotes.filter { $0.isFavorite == false }.count == 0, "Make sure we get only the favorite quote by checking that we have *NOT* non favorite quote")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
