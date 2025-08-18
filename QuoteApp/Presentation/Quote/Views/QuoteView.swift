//
//  QuoteView.swift
//  QuoteApp
//
//  Created by David on 10/08/2025.
//

import SwiftUI

struct QuoteView: View {
    @ObservedObject var quoteViewViewModel: QuoteViewViewModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack { Spacer() }
            if let quote = quoteViewViewModel.quote {
                ZStack(alignment: .leading) {
                    Text("la citation du jour 👇") // 🤘
                        .foregroundStyle(.gray)
                        .font(.title)
                        .padding([.top])
                        .padding([.top])
                        .opacity(quoteViewViewModel.idQuoteOfTheDay == quote.id ? 1 : 0)
                    Button {
                        quoteViewViewModel.fetchQuoteOfTheDay()
                    } label: {
                        Text("👈 revenir à la citation du jour")
                            .foregroundStyle(.gray)
                            .font(.callout)
                            .padding([.top])
                            .padding([.top])
                            .opacity(quoteViewViewModel.idQuoteOfTheDay == quote.id ? 0 : 1)
                    }
                }

                Text(quote.text)
                    .font(.custom("Hanken Grotesk", size: 34, relativeTo: .largeTitle))
                    .italic()
                    .padding([.top])
                    .padding([.top])
                HStack {
                    Spacer()
                    Text("de")
                        .foregroundStyle(.gray)
                    Text(quote.author)
                }
                .padding([.top])
                Spacer()
                HStack {
                    Spacer()
                    HeartButton(isFavorite: quote.isFavorite) {
                        quoteViewViewModel.switchIsFavorite()
                    }
                    .hidden()
                    Spacer()
                    RefreshButton {
                        quoteViewViewModel.fetchRandomQuote()
                    }
                    Spacer()
                    HeartButton(isFavorite: quote.isFavorite) {
                        quoteViewViewModel.switchIsFavorite()
                    }
                    Spacer()
                }
                .padding([.bottom])
                .padding([.bottom])
                .padding([.bottom])
            }
        }
        .padding([.leading, .trailing])
        .background {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 1.0, green: 0.98, blue: 0.80), // jaune pastel (#FFFACD)
                    Color(red: 0.80, green: 1.0, blue: 0.85) // vert pastel (#CCFFDA)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
    }
}

#Preview {
    let quoteRepository = InMemoryQuoteRepository(url: Bundle.main.url(forResource: "list-of-quotes", withExtension: "json")!)
    let getNotFavoriteRandomQuote = GetNotFavoriteRandomQuote(quoteRepository: quoteRepository)
    let switchIsFavoriteFlag = SwitchIsFavoriteFlag(quoteRepository: quoteRepository)
    let getQuoteById = GetQuoteById(quoteRepository: quoteRepository)
    let quoteViewViewModel = QuoteViewViewModel(
        getNotFavoriteRandomQuote: getNotFavoriteRandomQuote,
        switchIsFavoriteFlag: switchIsFavoriteFlag,
        getQuoteById: getQuoteById
    )
    QuoteView(quoteViewViewModel: quoteViewViewModel)
}
