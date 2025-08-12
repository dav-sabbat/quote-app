//
//  Untitled.swift
//  QuoteApp
//
//  Created by David on 10/08/2025.
//

struct InMemoryQuoteRepository: QuoteRepository {
    func fetch(by id: Int) -> Quote {
        return sample.first!
    }

    func fetchAll() -> [Quote] {
        return sample
    }
}

extension InMemoryQuoteRepository {
    var sample: [Quote] {
        [
            Quote(id: 1, text: "Vis comme si tu devais mourir demain. Apprends comme si tu devais vivre toujours", author: "Gandhi"),
            Quote(id: 2, text: "Les enfants seuls savent ce qu'ils cherchent", author: "Antoine de Saint-Exupéry"),
            Quote(id: 3, text: "La beauté de l'instant présent n'a pas de prix. Elle ne s'explique pas, elle se ressent et se vit", author: "Joëlle Laurencin"),
            Quote(id: 4, text: "Vis le présent, et les souvenirs t'accompagneront", author: "Nabil Alami"),
            Quote(id: 5, text: "Une photographie est un souvenir en hibernation qui nie l'écoulement du temps", author: "André Hardellet", originTitle: "Le parc des Archers", originYear: "1972"),
            Quote(id: 6, text: "Il faut toujours viser la lune, car même en cas d'échec, on atterrit dans les étoiles", author: "Oscar Wilde"),
        ]
    }
}
