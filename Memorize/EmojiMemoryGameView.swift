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
            Text("Score: \(viewModel.score)")
            Grid(viewModel.cards) { card in
                CardView(card: card)
                    .onTapGesture() {
                        withAnimation(.linear) {
                            viewModel.choose(card: card)
                        }
                    }
                    .aspectRatio(contentMode:.fit)
                    .padding(5.0)
            }
            .padding()
            .foregroundColor(EmojiMemoryGame.themeColor)
            Button(action: {
                withAnimation(.easeInOut) {
                    viewModel.newMemoryGame()
                }
            }, label: {
                Text("New Game")
            })
            Text("Theme: \(EmojiMemoryGame.themeName)")
        }.font(Font.system(size: 32))
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card

    @ViewBuilder var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration:card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size:CGSize) -> some View {
        if (card.isFaceUp || !card.isMatched) {
            ZStack {
                Group {
                    if (card.isConsumingBonusTime) {
                        Pie(startAngle: Angle(degrees: 0.0 - 90.0), endAngle: Angle(degrees: -(animatedBonusRemaining * 360.0) - 90.0), clockwise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0.0 - 90.0), endAngle: Angle(degrees: -(card.bonusRemaining * 360.0) - 90.0), clockwise: true)
                    }
                }.padding(5.0).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle(degrees: card.isMatched ? 360.0 : 0.0))
                    .animation(card.isMatched ? Animation.linear.repeatForever(autoreverses: false) : .default)
            }.cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
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
