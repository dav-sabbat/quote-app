//
//  QuoteList.swift
//  QuoteApp
//
//  Created by David on 12/08/2025.
//

import SwiftUI

struct FavoriteQuoteList: View {
    @State private var filter: QuoteViewFilterType = .quotes
    
    @ObservedObject var favoriteQuoteListViewModel: FavoriteQuoteListViewModel

    var body: some View {
        NavigationStack {
            VStack {
                HorizontalMenu(
                    filter: $filter,
                    favoriteQuoteListViewModel: favoriteQuoteListViewModel
                )
                ZStack {
                    List {
                        ForEach(favoriteQuoteListViewModel.quoteList) { quote in
                            FavoriteQuoteListRow(
                                id: quote.id,
                                text: quote.text,
                                author: quote.author,
                                isFavorite: quote.isFavorite,
                                favoriteQuoteListViewModel: favoriteQuoteListViewModel
                            )
                        }
                    }
                    .opacity(filter == .quotes ? 1 : 0)
                    .listStyle(.plain)
                    List {
                        ForEach(favoriteQuoteListViewModel.authorList) { (author: AuthorUIModel) in
                            VStack(alignment: .leading) {
                                Text(author.fullName)
                                Text("\(author.numberOfQuotes) citation\(author.numberOfQuotes > 1 ? "s" : "")")
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    .opacity(filter == .author ? 1 : 0)
                    .listStyle(.plain)
                }
            }
            .padding([.top])
            .background(content: {
                Color.background
                    .ignoresSafeArea()
            }).navigationTitle("mes favoris")
            .task {
                if filter == .quotes {
                    favoriteQuoteListViewModel.fetchQuoteFavoriteList()
                } else if filter == .author {
                    favoriteQuoteListViewModel.fetchAuthorListOfFavoriteQuotes()
                }
            }
        }
    }
}

enum QuoteViewFilterType {
    case quotes
    case author
}

struct FavoriteQuoteListRow: View {
    let id: Int
    let text: String
    let author: String
    let isFavorite: Bool

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
            } label: {
                Image(systemName: "heart\(isFavorite == true ? ".fill" : "")")
            }
            .buttonStyle(PlainButtonStyle()) // make only the button clickable, not the entire row
        }
    }
}

struct HorizontalMenu: View {
    @Binding var filter: QuoteViewFilterType
    @ObservedObject var favoriteQuoteListViewModel: FavoriteQuoteListViewModel

    var body: some View {
        HStack {
            Spacer()
            VStack {
                Button {
                    withAnimation {
                        filter = .quotes
                        favoriteQuoteListViewModel.fetchQuoteFavoriteList()
                    }
                } label: {
                    Text("Quotes")
                        .fontWeight(filter != .quotes ? .regular : .bold)
                }
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 100, height: 2)
                    .opacity(filter != .quotes ? 0 : 1)
            }
            Spacer()
            VStack {
                Button {
                    withAnimation {
                        filter = .author
                        favoriteQuoteListViewModel.fetchAuthorListOfFavoriteQuotes()
                    }
                } label: {
                    Text("Author")
                        .fontWeight(filter != .author ? .regular : .bold)
                }
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 100, height: 2)
                    .opacity(filter != .author ? 0 : 1)
            }
            Spacer()
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
