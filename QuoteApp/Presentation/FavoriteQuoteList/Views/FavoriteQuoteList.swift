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
                        FavoriteQuoteListRow(
                            id: quote.id,
                            text: quote.text,
                            author: quote.author,
                            isFavorite: quote.isFavorite,
                            favoriteQuoteListViewModel: favoriteQuoteListViewModel
                        )
                    }
                }
            }
            .listStyle(.plain)
        }
        .background(content: {
            Color.background
                .ignoresSafeArea()
        })
        .task {
            favoriteQuoteListViewModel.fetchQuoteFavoriteList()
        }
    }
}

struct FavoriteQuoteListRow: View {
    let id: Int
    let text: String
    let author: String
    @State var isFavorite: Bool
    
    // Todo: Pass une completion ici ?
    @ObservedObject var favoriteQuoteListViewModel: FavoriteQuoteListViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(text)
                    .font(.custom("Hanken Grotesk", size: 17, relativeTo: .body))
                    .italic()
                HStack {
                    Spacer()
                    Text(author)
                        .foregroundStyle(.gray)
                }
                .font(.subheadline)
            }
            Spacer()
            Button {
                favoriteQuoteListViewModel.switchIsFavoriteFlag(quoteId: id)
                isFavorite = !isFavorite // It allows the row to stay in the list until the list is reloaded
            } label: {
                Image(systemName: "heart\(isFavorite == true ? ".fill" : "")")
            }
        }
    }
}

#Preview {
    let quoteRepository = InMemoryQuoteRepository(url: Bundle.main.url(forResource: "list-of-quotes", withExtension: "json")!)
    let getAllFavoriteQuotes = GetAllFavoriteQuotes(quoteRepository: quoteRepository)
    let switchIsFavoriteFlag = SwitchIsFavoriteFlag(quoteRepository: quoteRepository)
    let favoriteQuoteListViewModel = FavoriteQuoteListViewModel(
        getAllFavoriteQuotes: getAllFavoriteQuotes,
        switchIsFavoriteFlag: switchIsFavoriteFlag
    )
    FavoriteQuoteList(favoriteQuoteListViewModel: favoriteQuoteListViewModel)
}
