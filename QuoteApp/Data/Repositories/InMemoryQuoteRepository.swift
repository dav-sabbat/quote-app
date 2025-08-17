//
//  Untitled.swift
//  QuoteApp
//
//  Created by David on 10/08/2025.
//

import Foundation

class InMemoryQuoteRepository: QuoteRepository {
    var quoteJsonList: [QuoteJson] = []

    init(url: URL) {
        if let data = try? Data(contentsOf: url),
           let decoded = try? JSONDecoder().decode([QuoteJson].self, from: data)
        {
            self.quoteJsonList = decoded
        } else {
            print("Impossible de charger le fichier")
        }
    }

    func fetch(by id: Int) throws -> Quote {
        convert(
            from: quoteJsonList.first { $0.id == id }!
        )
    }

    func fetchAll() throws -> [Quote] {
        quoteJsonList.map {
            convert(from: $0)
        }
    }

    func fetchAllFavoriteQuotes() throws -> [Quote] {
        quoteJsonList
            .filter { $0.isFavorite == true }
            .map { convert(from: $0) }
    }

    func fetchAllNotFavoriteQuotes() throws -> [Quote] {
        quoteJsonList
            .filter { $0.isFavorite == false }
            .map { convert(from: $0) }
    }

    func setIsFavorite(id: Int, isFavorite: Bool) throws {
        quoteJsonList
            .first { $0.id == id }!
            .isFavorite = isFavorite
    }

    func searchQuote(withText text: String) throws -> [Quote] {
        try quoteJsonList
            .filter {
                try $0.text.contains(Regex(text).ignoresCase())
            }
            .map { convert(from: $0) }
    }
}

extension InMemoryQuoteRepository {
    class QuoteJson: Codable {
        init(id: Int, text: String, author: String, isFavorite: Bool) {
            self.id = id
            self.text = text
            self.author = author
            self.isFavorite = isFavorite
        }

        let id: Int
        let text: String
        let author: String
        var isFavorite: Bool
    }
}

extension InMemoryQuoteRepository {
    private func convert(from quoteJsonFormat: QuoteJson) -> Quote {
        Quote(
            id: quoteJsonFormat.id,
            text: quoteJsonFormat.text,
            author: quoteJsonFormat.author,
            isFavorite: quoteJsonFormat.isFavorite
        )
    }
}
