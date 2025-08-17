//
//  SearchViewViewModel.swift
//  QuoteApp
//
//  Created by David on 16/08/2025.
//

import SwiftUI

class SearchViewViewModel: ObservableObject {
    @Published var quoteList: [QuoteUIModel] = []

    let searchForQuote: SearchForQuotes
    let switchIsFavoriteFlag: SwitchIsFavoriteFlag

    init(searchForQuote: SearchForQuotes, switchIsFavoriteFlag: SwitchIsFavoriteFlag) {
        self.searchForQuote = searchForQuote
        self.switchIsFavoriteFlag = switchIsFavoriteFlag
    }

    func fetchQuoteList(for stringForSearch: String) {
        if let quotesFiltered = try? searchForQuote.execute(withString: stringForSearch) {
            quoteList = quotesFiltered.map {
                QuoteUIModel(id: $0.id, text: $0.text, author: $0.author, isFavorite: $0.isFavorite)
            }
        }
    }

    func switchIsFavoriteFlag(quoteId: Int) {
        try? switchIsFavoriteFlag.execute(id: quoteId)
        // do not refresh quoteList so the unfavorite stay on screen
    }
}
