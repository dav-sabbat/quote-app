//
//  Quotes.swift
//  QuoteApp
//
//  Created by David on 10/08/2025.
//

protocol QuoteRepository {
    func fetch(by id: Int) -> Quote
    func fetchAll() -> [Quote]
}
