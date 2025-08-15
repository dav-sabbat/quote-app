//
//  QuoteViewModel.swift
//  QuoteApp
//
//  Created by David on 10/08/2025.
//

import SwiftUI

class QuoteViewViewModel: ObservableObject {
    let getRandomQuote: GetRandomQuote
    let switchIsFavoriteFlag: SwitchIsFavoriteFlag
    @Published var quote: QuoteUIModel?

    init(getRandomQuote: GetRandomQuote, switchIsFavoriteFlag: SwitchIsFavoriteFlag) {
        self.getRandomQuote = getRandomQuote
        self.switchIsFavoriteFlag = switchIsFavoriteFlag
    }

    func fetchRandomQuote() {
        do {
            let quote = try getRandomQuote.execute()
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
            switchIsFavoriteFlag.id = quote.id
            try? switchIsFavoriteFlag.execute()
            self.quote?.isFavorite = !quote.isFavorite
        }
    }
}
