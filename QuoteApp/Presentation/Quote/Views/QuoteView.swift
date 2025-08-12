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
            Spacer()
            if let quoteText = quoteViewViewModel.quote?.text {
                Text(quoteText)
                    .font(.custom("Hanken Grotesk", size: 34, relativeTo: .largeTitle))
                    .italic()
            } else {
                Text("...")
            }

            if let author = quoteViewViewModel.quote?.author {
                HStack {
                    Spacer()
                    Text("de")
                        .foregroundStyle(.gray)
                    Text(author)
                }
                .padding([.top])
            }
            Spacer()
            HStack {
                Spacer()
                Image(systemName: "heart")
                    .font(.title)
                    .hidden()
                Spacer()
                Button(action: {
                    quoteViewViewModel.fetchRandomQuote()
                }, label: {
                    Image(systemName: "arrow.trianglehead.2.clockwise")
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                        .opacity(0.6)
                })
                Spacer()
                Button {
                    quoteViewViewModel.switchIsFavorite()
                } label: {
                    Image(systemName: "heart\(quoteViewViewModel.quote?.isFavorite == true ? ".fill" : "")")
                        .font(.title)
                        .foregroundStyle(.black)
                        .opacity(0.6)
                }
                Spacer()
            }
            .padding([.bottom])
            .padding([.bottom])
            .padding([.bottom])
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
        .task {
            if quoteViewViewModel.quote == nil {
                quoteViewViewModel.fetchRandomQuote()
            }
        }
    }
}

#Preview {
    let quoteRepository = InMemoryQuoteRepository()
    let getRandomQuote = GetRandomQuote(quoteRepository: quoteRepository)
    let switchIsFavoriteFlag = SwitchIsFavoriteFlag(quoteRepository: quoteRepository)
    let quoteViewViewModel = QuoteViewViewModel(
        getRandomQuote: getRandomQuote,
        switchIsFavoriteFlag: switchIsFavoriteFlag
    )
    QuoteView(quoteViewViewModel: quoteViewViewModel)
}
