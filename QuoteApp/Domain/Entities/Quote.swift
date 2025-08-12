//
//  Quote.swift
//  QuoteApp
//
//  Created by David on 10/08/2025.
//

enum Theme {
    case general
}

enum Langage {
    case french
}

class Quote {
    init(id: Int, text: String, author: String, originTitle: String? = nil, originYear: String? = nil, theme: Theme = .general, language: Langage = .french) {
        self.id = id
        self.text = text
        self.author = author
        self.originTitle = originTitle
        self.originYear = originYear
        self.theme = theme
        self.language = language
    }

    let id: Int
    let text: String
    let author: String
    let originTitle: String?
    let originYear: String?
    let theme: Theme
    let language: Langage
}
