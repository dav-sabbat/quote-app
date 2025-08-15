//
//  AppDIContainer.swift
//  QuoteApp
//
//  Created by David on 11/08/2025.
//

import Foundation

protocol AppDIContainer {
    func makeQuoteRepository() -> QuoteRepository
    func makeQuoteAppSceneDIContainter() -> QuoteAppSceneDIContainer
}

class DemoAppDIContainer: AppDIContainer {
    func makeQuoteRepository() -> QuoteRepository {
        InMemoryQuoteRepository(url: Bundle.main.url(forResource: "list-of-quotes", withExtension: "json")!)
    }

    func makeQuoteAppSceneDIContainter() -> QuoteAppSceneDIContainer {
        QuoteAppSceneDIContainer(quoteRepository: makeQuoteRepository())
    }
}
