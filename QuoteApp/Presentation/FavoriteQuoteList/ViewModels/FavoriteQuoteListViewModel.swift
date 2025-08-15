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

    init(getAllFavoriteQuotes: GetAllFavoriteQuotes) {
        self.getAllFavoriteQuotes = getAllFavoriteQuotes
    }

    func fetchQuoteFavoriteList() {
        let favoriteQuoteList = (try? getAllFavoriteQuotes.execute()) ?? []
        quoteList = favoriteQuoteList.map { QuoteUIModel(id: $0.id, text: $0.text, author: $0.author, isFavorite: $0.isFavorite) }
    }
}
