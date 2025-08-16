//
//  Quotes.swift
//  QuoteApp
//
//  Created by David on 10/08/2025.
//

protocol QuoteRepository {
    func fetch(by id: Int) throws -> Quote
    func fetchAll() throws -> [Quote]
    func fetchAllFavoriteQuotes() throws -> [Quote]
    func fetchAllNotFavoriteQuotes() throws -> [Quote]

    func setIsFavorite(id: Int, isFavorite: Bool) throws
}
