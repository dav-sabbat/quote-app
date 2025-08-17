//
//  QuoteListViewModel.swift
//  QuoteApp
//
//  Created by David on 12/08/2025.
//

import SwiftUI

class FavoriteQuoteListViewModel: ObservableObject {
    @Published var quoteList: [QuoteUIModel] = []
    @Published var authorList: [AuthorUIModel] = []

    let getAllFavoriteQuotes: GetAllFavoriteQuotes
    let switchIsFavoriteFlag: SwitchIsFavoriteFlag

    init(getAllFavoriteQuotes: GetAllFavoriteQuotes, switchIsFavoriteFlag: SwitchIsFavoriteFlag) {
        self.getAllFavoriteQuotes = getAllFavoriteQuotes
        self.switchIsFavoriteFlag = switchIsFavoriteFlag
    }

    func fetchQuoteFavoriteList() {
        do {
            let favoriteQuoteList = try getAllFavoriteQuotes.execute()
            quoteList = favoriteQuoteList
                .map {
                    QuoteUIModel(
                        id: $0.id,
                        text: $0.text,
                        author: $0.author,
                        isFavorite: $0.isFavorite
                    )
                }
        } catch {
            print("cannot fetch quote favorite list")
        }
    }

    func fetchAuthorListOfFavoriteQuotes() {
        do {
            let favoriteQuoteList = try getAllFavoriteQuotes.execute()
            let authors = Dictionary(grouping: favoriteQuoteList, by: { $0.author })
            authorList = authors
                .keys
                .map {
                    AuthorUIModel(
                        id: $0.hashValue,
                        fullName: $0,
                        numberOfQuotes: authors[$0]?.count ?? 0
                    )
                }
                .sorted {
                    $0.fullName < $1.fullName
                }
        } catch {
            print("cannot fetch author list of favorite quotes")
        }
    }

    func switchIsFavoriteFlag(quoteId: Int) {
        do {
            try switchIsFavoriteFlag.execute(id: quoteId)
            fetchQuoteFavoriteList()
        } catch {
            print("cannot toggle is favorite flag")
        }
    }
}
