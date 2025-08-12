//
//  QuoteAppApp.swift
//  QuoteApp
//
//  Created by David on 10/08/2025.
//

import SwiftUI

@main
struct QuoteAppApp: App {
    let quoteAppSceneDIContainter: QuoteAppSceneDIContainer
    let quoteAppSceneRouter: QuoteAppSceneRouter

    init() {
        let demoAppDIContainer = DemoAppDIContainer()
        quoteAppSceneDIContainter = demoAppDIContainer.makeQuoteAppSceneDIContainter()
        quoteAppSceneRouter = quoteAppSceneDIContainter.makeQuoteAppSceneRouter()
    }

    var body: some Scene {
        WindowGroup {
            AppTabBar(
                quoteAppSceneDIContainter: quoteAppSceneDIContainter,
                quoteAppSceneRouter: quoteAppSceneRouter
            )
            .preferredColorScheme(.light)
        }
    }
}
