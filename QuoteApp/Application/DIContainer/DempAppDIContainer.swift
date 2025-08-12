//
//  AppDIContainer.swift
//  QuoteApp
//
//  Created by David on 11/08/2025.
//

protocol AppDIContainer {
    func makeQuoteRepository() -> QuoteRepository
    func makeQuoteAppSceneDIContainter() -> QuoteAppSceneDIContainer
}

class DemoAppDIContainer: AppDIContainer {
    func makeQuoteRepository() -> QuoteRepository {
        InMemoryQuoteRepository()
    }

    func makeQuoteAppSceneDIContainter() -> QuoteAppSceneDIContainer {
        QuoteAppSceneDIContainer(quoteRepository: makeQuoteRepository())
    }
}
