//
//  Cardify.swift
//  Memorize
//
//  Created by Eli Manjarrez on 10/27/20.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    func body(content: Content) -> some View {
        ZStack {
            if (isFaceUp) {
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let lineWidth: CGFloat = 3.0
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
