//
//  GetRandomQuote.swift
//  QuoteApp
//
//  Created by David on 11/08/2025.
//

enum GetNotFavoriteRandomQuoteError: Error {
    case cannotFindQuote
}

class GetNotFavoriteRandomQuote: UseCase {
    let quoteRepository: QuoteRepository

    init(quoteRepository: QuoteRepository) {
        self.quoteRepository = quoteRepository
    }

    func execute() throws -> Quote {
        let allQuotes = try self.quoteRepository.fetchAllNotFavoriteQuotes()
        if let quote = allQuotes.randomElement() {
            return quote
        }
        throw GetNotFavoriteRandomQuoteError.cannotFindQuote
    }
}
