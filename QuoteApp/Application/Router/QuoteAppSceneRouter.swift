//
//  QuoteAppSceneRouter.swift
//  QuoteApp
//
//  Created by David on 11/08/2025.
//

class QuoteAppSceneRouter {
    let quoteAppSceneDIContainer: QuoteAppSceneDIContainer
    
    init(quoteAppSceneDIContainer: QuoteAppSceneDIContainer) {
        self.quoteAppSceneDIContainer = quoteAppSceneDIContainer
    }
    
    func makeQuoteView() -> QuoteView {
        let viewModel = quoteAppSceneDIContainer.makeQuoteViewViewModel()
        return QuoteView(quoteViewViewModel: viewModel)
    }
}
