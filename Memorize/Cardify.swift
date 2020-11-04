//
//  Cardify.swift
//  Memorize
//
//  Created by Eli Manjarrez on 10/27/20.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    var isFaceUp: Bool {
        rotation < 90.0
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0.0 : 180.0
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                content
            }.opacity(isFaceUp ? 1.0 : 0.0)
            RoundedRectangle(cornerRadius: cornerRadius).fill().opacity(isFaceUp ? 0.0 : 1.0)
        }
        .rotation3DEffect(Angle(degrees: rotation), axis: (x: 0.0, y: 1.0, z: 0.0)
            )
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let lineWidth: CGFloat = 3.0
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
