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
    
    // MARK: fetch()
    
    func testFetchQuoteInSuccess() throws {
        // Given
        let repo = InMemoryQuoteRepository(
            url: Bundle(for: type(of: self)).url(forResource: dataResource, withExtension: "json")!
        )
        
        // When
        let quote = try repo.fetch(by: 3)
        
        // Then
        XCTAssert(quote.id == 3, "Id should be 3")
        XCTAssert(quote.text == "Fais de ta vie un rêve, et d’un rêve, une réalité.", "Quote text should be the right one")
        XCTAssert(quote.author == "Antoine de Saint-Exupéry")
    }
    
    // MARK: fetchAll()

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
    
    // MARK: fetchAllFavoriteQuotes()
    
    func testfetchAllFavoriteQuotesInSuccess() throws {
        // Given
        let repo = InMemoryQuoteRepository(
            url: Bundle(for: type(of: self)).url(forResource: dataResource, withExtension: "json")!
        )

        // When
        let quotes = try repo.fetchAllFavoriteQuotes()

        // Then
        XCTAssert(quotes.count == 14, "Make sure it retrieves 13 favorite quotes from a data file")
        XCTAssert(quotes.first!.id == 1, "Make sure the first favorite quote of the file is id=1")
        XCTAssert(quotes.first!.isFavorite == true, "Make sure the first favorite quote has the prop isFavorite set to true")
        XCTAssert(quotes.last!.id == 25, "Make sure the last favorite quote of the file is id=25")
    }
    
    // MARK: fetchAllNotFavoriteQuotes()
    
    func testfetchAllNotFavoriteQuotesInSuccess() throws {
        // Given
        let repo = InMemoryQuoteRepository(
            url: Bundle(for: type(of: self)).url(forResource: dataResource, withExtension: "json")!
        )

        // When
        let quotes = try repo.fetchAllNotFavoriteQuotes()

        // Then
        XCTAssert(quotes.count == 12, "Make sure it retrieves 13 favorite quotes from a data file")
        XCTAssert(quotes.first!.id == 4, "Make sure the first favorite quote of the file is id=1")
        XCTAssert(quotes.first!.isFavorite == false, "Make sure the first favorite quote has the prop isFavorite set to true")
        XCTAssert(quotes.last!.id == 26, "Make sure the last favorite quote of the file is id=25")
    }
    
    // MARK: setIsFavorite()
    
    func testSetIsFavoriteFlagFromFalseToTrueInSuccess() throws {
        // Given
        let repo = InMemoryQuoteRepository(
            url: Bundle(for: type(of: self)).url(forResource: "list-of-one-quote-with-is-favorite-at-false", withExtension: "json")!
        )
        
        // When
        let quote = try repo.fetchAll().first!
        try repo.setIsFavorite(id: quote.id, isFavorite: true)
        
        // Then
        let quoteModified = try repo.fetch(by: quote.id)
        XCTAssert(quoteModified.isFavorite == true, "Modify the isFavorite flag from false to true in success")
    }
    
    func testSetIsFavoriteFlagFromTrueToFalseInSuccess() throws {
        // Given
        let repo = InMemoryQuoteRepository(
            url: Bundle(for: type(of: self)).url(forResource: "list-of-one-quote-with-is-favorite-at-true", withExtension: "json")!
        )
        
        // When
        let quote = try repo.fetchAll().first!
        try repo.setIsFavorite(id: quote.id, isFavorite: false)
        
        // Then
        let quoteModified = try repo.fetch(by: quote.id)
        XCTAssert(quoteModified.isFavorite == false, "Modify the isFavorite flag from true to false in success")
    }
    
    func testSetIsFavoriteFlagInSuccess() throws {
        // Given
        let repo = InMemoryQuoteRepository(
            url: Bundle(for: type(of: self)).url(forResource: dataResource, withExtension: "json")!
        )
        
        // When
        let quote = try repo.fetchAll().first!
        let isFavoriteFlagOriginalValue = quote.isFavorite
        try repo.setIsFavorite(id: quote.id, isFavorite: !isFavoriteFlagOriginalValue)
        
        // Then
        let quoteModified = try repo.fetch(by: quote.id)
        XCTAssert(isFavoriteFlagOriginalValue == !quoteModified.isFavorite, "Modify the isFavorite flag in success")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
