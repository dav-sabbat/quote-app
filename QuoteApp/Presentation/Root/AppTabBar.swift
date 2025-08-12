//
//  AppTabBar.swift
//  QuoteApp
//
//  Created by David on 10/08/2025.
//

import SwiftUI

struct AppTabBar: View {
    let quoteAppSceneDIContainter: QuoteAppSceneDIContainer
    let quoteAppSceneRouter: QuoteAppSceneRouter

    var body: some View {
        let quoteView = quoteAppSceneRouter.makeQuoteView()
        TabView {
            quoteView
                .tabItem {
                    Image(systemName: "quote.opening")
                }
            Text("Favoris")
                .tabItem {
                    Image(systemName: "heart")
                }
            Text("Recherche")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
        }
    }
}

#Preview {
    let demoAppDIContainer = DemoAppDIContainer()
    let quoteAppSceneDIContainter = demoAppDIContainer.makeQuoteAppSceneDIContainter()
    let quoteAppSceneRouter = quoteAppSceneDIContainter.makeQuoteAppSceneRouter()
    AppTabBar(
        quoteAppSceneDIContainter: quoteAppSceneDIContainter,
        quoteAppSceneRouter: quoteAppSceneRouter
    )
}
