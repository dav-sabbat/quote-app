//
//  QuoteList.swift
//  QuoteApp
//
//  Created by David on 12/08/2025.
//

import SwiftUI

struct FavoriteQuoteList: View {
    @ObservedObject var favoriteQuoteListViewModel: FavoriteQuoteListViewModel

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Quotes") {}
                Spacer()
                Button("Author") {}
                Spacer()
                Button("Tags") {}
                Spacer()
            }
            List {
                if let quoteList = favoriteQuoteListViewModel.quoteList {
                    ForEach(quoteList) { quote in
                        FavoriteQuoteListRow(text: quote.text, author: quote.author, isFavorite: quote.isFavorite)
                    }
                }
            }
            .listStyle(.plain)
        }
        .task {
            favoriteQuoteListViewModel.fetchQuoteFavoriteList()
        }
    }
}

struct FavoriteQuoteListRow: View {
    let text: String
    let author: String
    let isFavorite: Bool

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(text)
                HStack {
                    Spacer()
                    Text(author)
                }
            }
            Spacer()
            Image(systemName: "heart\(isFavorite == true ? ".fill" : "")")
        }
    }
}

#Preview {
    let quoteRepository = InMemoryQuoteRepository(url: Bundle.main.url(forResource: "list-of-quotes", withExtension: "json")!)
    let getAllFavoriteQuotes = GetAllFavoriteQuotes(quoteRepository: quoteRepository)
    let favoriteQuoteListViewModel = FavoriteQuoteListViewModel(getAllFavoriteQuotes: getAllFavoriteQuotes)
    FavoriteQuoteList(favoriteQuoteListViewModel: favoriteQuoteListViewModel)
}
