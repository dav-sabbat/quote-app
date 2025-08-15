//
//  SwitchIsFavorite.swift
//  QuoteApp
//
//  Created by David on 12/08/2025.
//

enum SwitchIsFavoriteFlagError: Error {
    case idIsNil
}

class SwitchIsFavoriteFlag: UseCase {
    var id: Int?
    let quoteRepository: QuoteRepository

    init(quoteRepository: QuoteRepository) {
        self.quoteRepository = quoteRepository
    }

    func execute() throws {
        if let id = id {
            let quote = try quoteRepository.fetch(by: id)
            try quoteRepository.setIsFavorite(id: id, isFavorite: !quote.isFavorite)
        } else {
            throw SwitchIsFavoriteFlagError.idIsNil
        }
    }
}
