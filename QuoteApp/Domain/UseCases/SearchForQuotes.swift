//
//  SearchForQuote.swift
//  QuoteApp
//
//  Created by David on 16/08/2025.
//

class SearchForQuotes: UseCase {
    let quoteRepository: QuoteRepository

    init(quoteRepository: QuoteRepository) {
        self.quoteRepository = quoteRepository
    }

    func execute(withString string: String) throws -> [Quote] {
        try quoteRepository.searchQuote(withText: string)
    }
}
