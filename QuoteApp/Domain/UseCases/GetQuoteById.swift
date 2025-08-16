//
//  GetQuoteById.swift
//  QuoteApp
//
//  Created by David on 15/08/2025.
//

class GetQuoteById: UseCase {
    let quoteRepository: QuoteRepository

    init(quoteRepository: QuoteRepository) {
        self.quoteRepository = quoteRepository
    }

    func execute(id: Int) throws -> Quote {
        try quoteRepository.fetch(by: id)
    }
}
