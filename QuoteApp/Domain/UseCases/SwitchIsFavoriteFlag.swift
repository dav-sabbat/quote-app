//
//  SwitchIsFavorite.swift
//  QuoteApp
//
//  Created by David on 12/08/2025.
//

class SwitchIsFavoriteFlag: UseCase {
    let quoteRepository: QuoteRepository

    init(quoteRepository: QuoteRepository) {
        self.quoteRepository = quoteRepository
    }

    func execute(id: Int) throws {
        let quote = try quoteRepository.fetch(by: id)
        try quoteRepository.setIsFavorite(id: id, isFavorite: !quote.isFavorite)
    }
}
