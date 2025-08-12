//
//  QuoteViewModel.swift
//  QuoteApp
//
//  Created by David on 10/08/2025.
//

import SwiftUI

class QuoteViewViewModel: ObservableObject {
    let getRandomQuote: GetRandomQuote
    @Published var quote: QuoteUIModel?

    init(getRandomQuote: GetRandomQuote) {
        self.getRandomQuote = getRandomQuote
    }

    func fetchQuote() {
        do {
            let quote = try getRandomQuote.execute()
            self.quote = QuoteUIModel(
                id: quote.id,
                text: quote.text,
                author: quote.author
            )
        } catch {
            self.quote = QuoteUIModel(id: 1, text: "", author: "")
        }
    }
}

struct QuoteUIModel {
    let id: Int
    let text: String
    let author: String
}
