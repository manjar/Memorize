//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Eli Manjarrez on 9/23/20.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.newMemoryGame()
            }, label: {
                Text("New game")
            })
            Text("Score: \(viewModel.score)")
            Grid(viewModel.cards) { card in
                CardView(card: card)
                    .onTapGesture() {
                        viewModel.choose(card: card)
                    }
                    .aspectRatio(contentMode:.fit)
                    .padding(5.0)
            }
            .padding()
            .foregroundColor(Color.orange)
            Text("Theme: \(EmojiMemoryGame.themeName)")
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card

    @ViewBuilder var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    func body(for size:CGSize) -> some View {
        ZStack {
            if (card.isFaceUp) {
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                Text(card.content)
            } else if !card.isMatched {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            } else {
                EmptyView()
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let lineWidth: CGFloat = 3.0
    private func fontSize(for size:CGSize) -> CGFloat {
        24.0
//        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
