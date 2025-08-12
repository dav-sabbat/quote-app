//
//  GetRandomQuote.swift
//  QuoteApp
//
//  Created by David on 11/08/2025.
//

enum QuoteError: Error {
    case cannotFindQuote
}

struct GetRandomQuote {
    let quoteRepository: QuoteRepository

    init(quoteRepository: QuoteRepository) {
        self.quoteRepository = quoteRepository
    }

    func execute() throws -> Quote {
        let allQuotes = self.quoteRepository.fetchAll()
        if let quote = allQuotes.randomElement() {
            return quote
        }
        throw QuoteError.cannotFindQuote
    }
}
