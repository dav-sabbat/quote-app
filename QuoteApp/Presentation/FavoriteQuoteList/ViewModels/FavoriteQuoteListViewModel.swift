//
//  QuoteListViewModel.swift
//  QuoteApp
//
//  Created by David on 12/08/2025.
//

import SwiftUI

class FavoriteQuoteListViewModel: ObservableObject {
    @Published var quoteList: [QuoteUIModel]?

    let getAllFavoriteQuotes: GetAllFavoriteQuotes
    let switchIsFavoriteFlag: SwitchIsFavoriteFlag

    init(getAllFavoriteQuotes: GetAllFavoriteQuotes, switchIsFavoriteFlag: SwitchIsFavoriteFlag) {
        self.getAllFavoriteQuotes = getAllFavoriteQuotes
        self.switchIsFavoriteFlag = switchIsFavoriteFlag
    }

    func fetchQuoteFavoriteList() {
        let favoriteQuoteList = (try? getAllFavoriteQuotes.execute()) ?? []
        quoteList = favoriteQuoteList.map { QuoteUIModel(id: $0.id, text: $0.text, author: $0.author, isFavorite: $0.isFavorite) }
    }

    func switchIsFavoriteFlag(quoteId: Int) {
        try? switchIsFavoriteFlag.execute(id: quoteId)
        // do not refresh quoteList so the unfavorite stay on screen
    }
}
