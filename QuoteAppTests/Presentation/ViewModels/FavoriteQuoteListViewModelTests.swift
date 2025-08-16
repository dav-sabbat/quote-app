//
//  FavoriteQuoteListViewModelTests.swift
//  QuoteAppTests
//
//  Created by David on 16/08/2025.
//

import XCTest

final class FavoriteQuoteListViewModelTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // Given
        let repository = InMemoryQuoteRepository(
            url: Bundle(for: type(of: self)).url(forResource: "list-of-quotes-with-3-different-authors", withExtension: "json")!
        )
        let getAllFavoriteQuotes = GetAllFavoriteQuotes(quoteRepository: repository)
        let switchIsFavoriteFlag = SwitchIsFavoriteFlag(quoteRepository: repository)
        let favoriteQuoteListViewModel = FavoriteQuoteListViewModel(
            getAllFavoriteQuotes: getAllFavoriteQuotes,
            switchIsFavoriteFlag: switchIsFavoriteFlag
        )

        // When
        favoriteQuoteListViewModel.fetchAuthorListOfFavoriteQuotes()

        // Then
        XCTAssert(favoriteQuoteListViewModel.authorList?.count == 3, "Should have a list of 3 authors")
        XCTAssert(favoriteQuoteListViewModel.authorList?.first(where: { $0.fullName == "author1" })?.fullName == "author1", "First quote should have the author named as 'author1'")
        XCTAssert(favoriteQuoteListViewModel.authorList?.first(where: { $0.fullName == "author1" })?.numberOfQuotes == 3, "'author1' should have 3 associated quote")
        XCTAssert(favoriteQuoteListViewModel.authorList?.first(where: { $0.fullName == "author2" })?.numberOfQuotes == 2, "'author2' should have 2 associated quote, and *NOT* 3, because the third one is *NOT* a favorite")
        XCTAssert(favoriteQuoteListViewModel.authorList?.first(where: { $0.fullName == "author3" })?.numberOfQuotes == 1, "'author3' should have 1 associated quote")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
