//
//  Untitled.swift
//  QuoteApp
//
//  Created by David on 10/08/2025.
//

// enum InMemoryError: Error {
//    case cannotSwithIsFavorite
// }

class InMemoryQuoteRepository: QuoteRepository {
    func fetch(by id: Int) throws -> Quote? {
        sample.first { $0.id == id }
    }

    func fetchAll() throws -> [Quote] {
        return sample
    }

    func setIsFavorite(id: Int, isFavorite: Bool) throws {
        if let quote = try fetch(by: id) {
            quote.isFavorite = isFavorite
        }
    }

    var sample: [Quote] = [
        Quote(id: 1, text: "Vis comme si tu devais mourir demain. Apprends comme si tu devais vivre toujours", author: "Gandhi", isFavorite: true),
        Quote(id: 2, text: "Les enfants seuls savent ce qu'ils cherchent", author: "Antoine de Saint-Exupéry", isFavorite: true),
        Quote(id: 3, text: "La beauté de l'instant présent n'a pas de prix. Elle ne s'explique pas, elle se ressent et se vit", author: "Joëlle Laurencin", isFavorite: false),
        Quote(id: 4, text: "Vis le présent, et les souvenirs t'accompagneront", author: "Nabil Alami", isFavorite: true),
        Quote(id: 5, text: "Une photographie est un souvenir en hibernation qui nie l'écoulement du temps", author: "André Hardellet", originTitle: "Le parc des Archers", originYear: "1972", isFavorite: false),
        Quote(id: 6, text: "Il faut toujours viser la lune, car même en cas d'échec, on atterrit dans les étoiles", author: "Oscar Wilde", isFavorite: true),
    ]
}
