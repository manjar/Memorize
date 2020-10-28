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
            .foregroundColor(EmojiMemoryGame.themeColor)
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
    
    @ViewBuilder
    private func body(for size:CGSize) -> some View {
        if (card.isFaceUp || !card.isMatched) {
            ZStack {
                Pie(startAngle: Angle(degrees: 0.0 - 90.0), endAngle: Angle(degrees: 110 - 90.0), clockwise: true).padding(5.0).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle(degrees: card.isMatched ? 360.0 : 0.0))
                    .animation(card.isMatched ? Animation.linear(duration: 1.0).repeatForever(autoreverses: false) : .default)
            }.cardify(isFaceUp: card.isFaceUp)
        } else {
            EmptyView()
        }
    }
    
    private func fontSize(for size:CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
