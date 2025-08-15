//
//  GetAllFavoriteQuotes.swift
//  QuoteApp
//
//  Created by David on 13/08/2025.
//

class GetAllFavoriteQuotes: UseCase {
    let quoteRepository: QuoteRepository
    
    init(quoteRepository: QuoteRepository) {
        self.quoteRepository = quoteRepository
    }
    
    func execute() throws -> [Quote] {
        try quoteRepository.fetchAllFavoriteQuotes()
    }
}
