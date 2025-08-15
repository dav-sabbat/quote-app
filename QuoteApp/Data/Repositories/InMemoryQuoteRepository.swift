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
        convert(from:
            quoteJsonList.first { $0.id == id }!
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

    func setIsFavorite(id: Int, isFavorite: Bool) throws {
        try (fetch(by: id)).isFavorite = isFavorite
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
        let isFavorite: Bool
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
