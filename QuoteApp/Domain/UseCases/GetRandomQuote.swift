//
//  GetRandomQuote.swift
//  QuoteApp
//
//  Created by David on 11/08/2025.
//

enum GetRandomQuoteError: Error {
    case cannotFindQuote
}

class GetRandomQuote: UseCase {
    let quoteRepository: QuoteRepository

    init(quoteRepository: QuoteRepository) {
        self.quoteRepository = quoteRepository
    }

    func execute() throws -> Quote {
        let allQuotes = try self.quoteRepository.fetchAll()
        if let quote = allQuotes.randomElement() {
            return quote
        }
        throw GetRandomQuoteError.cannotFindQuote
    }
}
