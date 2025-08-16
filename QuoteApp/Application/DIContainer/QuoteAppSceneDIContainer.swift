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
        QuoteViewViewModel(
            getNotFavoriteRandomQuote: makeGetNotFavoriteRandomQuote(),
            switchIsFavoriteFlag: makeSwitchIsFavoriteFlag(),
            getQuoteById: makeGetQuoteById()
        )
    }

    func makeFavoriteQuoteListViewModel() -> FavoriteQuoteListViewModel {
        FavoriteQuoteListViewModel(
            getAllFavoriteQuotes: makeGetAllFavoriteQuotes(),
            switchIsFavoriteFlag: makeSwitchIsFavoriteFlag()
        )
    }

    // MARK: Use Cases

    func makeGetNotFavoriteRandomQuote() -> GetNotFavoriteRandomQuote {
        GetNotFavoriteRandomQuote(quoteRepository: quoteRepository)
    }

    func makeSwitchIsFavoriteFlag() -> SwitchIsFavoriteFlag {
        SwitchIsFavoriteFlag(quoteRepository: quoteRepository)
    }

    func makeGetAllFavoriteQuotes() -> GetAllFavoriteQuotes {
        GetAllFavoriteQuotes(quoteRepository: quoteRepository)
    }

    func makeGetQuoteById() -> GetQuoteById {
        GetQuoteById(quoteRepository: quoteRepository)
    }
}
