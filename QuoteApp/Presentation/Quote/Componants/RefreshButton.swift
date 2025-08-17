//
//  RefreshButton.swift
//  QuoteApp
//
//  Created by David on 17/08/2025.
//

import SwiftUI

struct RefreshButton: View {
    @State private var rotationAngle: Double = 0
    
    let buttonAction: () -> Void

    init(buttonAction: @escaping () -> Void) {
        self.buttonAction = buttonAction
    }

    var body: some View {
        Button(action: {
            withAnimation {
                rotationAngle += 1080
            } completion: {
                buttonAction()
            }
        }, label: {
            Image(systemName: "arrow.trianglehead.2.clockwise")
                .font(.largeTitle)
                .foregroundStyle(.black)
                .opacity(0.6)
                .rotationEffect(Angle(degrees: rotationAngle))
        })
    }
}
