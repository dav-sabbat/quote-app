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
    
    private var currentStringForSearch: String = ""

    init(searchForQuote: SearchForQuotes, switchIsFavoriteFlag: SwitchIsFavoriteFlag) {
        self.searchForQuote = searchForQuote
        self.switchIsFavoriteFlag = switchIsFavoriteFlag
    }

    func fetchQuoteList(for stringForSearch: String) {
        do {
            currentStringForSearch = stringForSearch
            let quotesFiltered = try searchForQuote.execute(withString: stringForSearch)
            quoteList = quotesFiltered
                .map {
                    QuoteUIModel(
                        id: $0.id,
                        text: $0.text,
                        author: $0.author,
                        isFavorite: $0.isFavorite
                    )
                }
        } catch {
            print("cannot fetch quote list")
        }
    }

    func switchIsFavoriteFlag(quoteId: Int) {
        do {
            try switchIsFavoriteFlag.execute(id: quoteId)
            fetchQuoteList(for: currentStringForSearch)
        } catch {
            print("cannot switch is favorite flag")
        }
    }
}
