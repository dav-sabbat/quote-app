//
//  QuoteAppSceneDIContainer.swift
//  QuoteApp
//
//  Created by David on 11/08/2025.
//

class QuoteAppSceneDIContainer {
    let quoteRepository: QuoteRepository

    init(quoteRepository: QuoteRepository) {
        self.quoteRepository = quoteRepository
    }

    // MARK: Router

    func makeQuoteAppSceneRouter() -> QuoteAppSceneRouter {
        QuoteAppSceneRouter(quoteAppSceneDIContainer: self)
    }

    // MARK: View Model

    func makeQuoteViewViewModel() -> QuoteViewViewModel {
        QuoteViewViewModel(getRandomQuote: makeGetRandomQuote())
    }

    // MARK: Use Cases

    func makeGetRandomQuote() -> GetRandomQuote {
        GetRandomQuote(quoteRepository: quoteRepository)
    }
}
