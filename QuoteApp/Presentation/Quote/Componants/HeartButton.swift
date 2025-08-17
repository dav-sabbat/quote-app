//
//  HeartButton.swift
//  QuoteApp
//
//  Created by David on 17/08/2025.
//

import SwiftUI

struct HeartButton: View {
    var isFavorite: Bool
    let buttonAction: () -> Void

    var body: some View {
        Button {
            buttonAction()
        } label: {
            Image(systemName: "heart\(isFavorite == true ? ".fill" : "")")
                .font(.title)
                .foregroundStyle(.black)
                .opacity(0.6)
        }
    }
}
