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

    var body: some View {
        GeometryReader { geometry in
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
            .font(Font.system(size: min(geometry.size.width, geometry.size.height) * fontScaleFactor))
        }
    }
    
    let cornerRadius: CGFloat = 10.0
    let lineWidth: CGFloat = 3.0
    let fontScaleFactor: CGFloat = 0.75
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
