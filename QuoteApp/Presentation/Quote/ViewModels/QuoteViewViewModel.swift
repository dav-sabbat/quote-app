//
//  QuoteViewModel.swift
//  QuoteApp
//
//  Created by David on 10/08/2025.
//

import SwiftUI

class QuoteViewViewModel: ObservableObject {
    let getNotFavoriteRandomQuote: GetNotFavoriteRandomQuote
    let switchIsFavoriteFlag: SwitchIsFavoriteFlag
    let getQuoteById: GetQuoteById
    @Published var quote: QuoteUIModel?

    init(getNotFavoriteRandomQuote: GetNotFavoriteRandomQuote, switchIsFavoriteFlag: SwitchIsFavoriteFlag, getQuoteById: GetQuoteById) {
        self.getNotFavoriteRandomQuote = getNotFavoriteRandomQuote
        self.switchIsFavoriteFlag = switchIsFavoriteFlag
        self.getQuoteById = getQuoteById
    }

    func fetchRandomQuote() {
        do {
            let quote = try getNotFavoriteRandomQuote.execute()
            self.quote = QuoteUIModel(
                id: quote.id,
                text: quote.text,
                author: quote.author,
                isFavorite: quote.isFavorite
            )
        } catch {
            print("cannot fetch quote")
        }
    }

    func switchIsFavorite() {
        if let quote = quote {
            try? switchIsFavoriteFlag.execute(id: quote.id)
            if let updatedQuote = try? getQuoteById.execute(id: quote.id) {
                self.quote = QuoteUIModel(
                    id: updatedQuote.id,
                    text: updatedQuote.text,
                    author: updatedQuote.author,
                    isFavorite: updatedQuote.isFavorite
                )
            }
        }
    }
}
