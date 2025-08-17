//
//  SearchView.swift
//  QuoteApp
//
//  Created by David on 16/08/2025.
//

import Combine
import SwiftUI

struct SearchView: View {
    @ObservedObject var searchViewViewModel: SearchViewViewModel

    @State var textFieldText: String = ""
    @State var publisher = PassthroughSubject<String, Never>()
    let debounceSeconds = 0.250

    var body: some View {
        VStack {
            TextField("Rechercher ...", text: $textFieldText)
                .textFieldStyle(.plain)
                .background(.clear)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .font(.title)
                .onChange(of: textFieldText) { _, newValue in
                    publisher.send(newValue)
                }
                .onReceive(
                    publisher.debounce(
                        for: .seconds(debounceSeconds),
                        scheduler: DispatchQueue.main
                    )
                ) { value in
                    searchViewViewModel.fetchQuoteList(for: value)
                }
                .padding([.leading, .trailing])
                .padding([.leading, .trailing])
                .padding([.top, .bottom])
                .animation(.easeIn, value: textFieldText)
            List {
                ForEach(searchViewViewModel.quoteList) { (quote: QuoteUIModel) in
                    SearchViewRow(
                        searchViewViewModel: searchViewViewModel,
                        id: quote.id,
                        text: quote.text,
                        author: quote.author,
                        isFavorite: quote.isFavorite
                    )
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .listRowSpacing(20)
            .frame(maxHeight: textFieldText.count > 0 ? .infinity : 0)
//            .frame(maxHeight: .infinity)
            .animation(.easeIn, value: textFieldText)
            .listStyle(.plain)
        }
        .frame(maxHeight: .infinity)
        .background {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.87, green: 0.82, blue: 0.95), // lavande pastel
                    Color(red: 0.96, green: 0.94, blue: 0.88) // beige pastel
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
    }
}

struct SearchViewRow: View {
    @ObservedObject var searchViewViewModel: SearchViewViewModel

    let id: Int
    let text: String
    let author: String
    @State var isFavorite: Bool

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(text)
                    .font(.custom("Hanken Grotesk", size: 18, relativeTo: .body))
                    .italic()
                HStack {
                    Spacer()
                    Text("de")
                        .foregroundStyle(.gray)
                    Text(author)
                }
                .font(.subheadline)
            }
            Spacer()
            Button {
                searchViewViewModel.switchIsFavoriteFlag(quoteId: id)
                isFavorite.toggle()
            } label: {
                Image(systemName: "heart\(isFavorite == true ? ".fill" : "")")
            }
            .buttonStyle(PlainButtonStyle()) // make only the button clickable, not the entire row
        }
    }
}

#Preview {
    let quoteRepository = InMemoryQuoteRepository(url: Bundle.main.url(forResource: "list-of-quotes", withExtension: "json")!)
    let searchForQuote = SearchForQuotes(quoteRepository: quoteRepository)
    let switchIsFavoriteFlag = SwitchIsFavoriteFlag(quoteRepository: quoteRepository)
    let searchViewViewModel = SearchViewViewModel(searchForQuote: searchForQuote, switchIsFavoriteFlag: switchIsFavoriteFlag)
    SearchView(searchViewViewModel: searchViewViewModel)
}
