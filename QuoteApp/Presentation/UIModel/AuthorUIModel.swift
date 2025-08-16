//
//  AuthorUIModel.swift
//  QuoteApp
//
//  Created by David on 16/08/2025.
//

class AuthorUIModel: Identifiable {
    let id: Int
    let fullName: String
    let numberOfQuotes: Int

    init(id: Int, fullName: String, numberOfQuotes: Int) {
        self.id = id
        self.fullName = fullName
        self.numberOfQuotes = numberOfQuotes
    }
}
