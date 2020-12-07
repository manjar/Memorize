//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Eli Manjarrez on 9/23/20.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var gameViewModel: EmojiMemoryGame
    @ObservedObject var themeModel: EmojiMemoryGameThemeViewModel
    @State var themePickerShowing: Bool = false
    
    var body: some View {
        VStack {
            Text("Score: \(gameViewModel.score)")
            Grid(gameViewModel.cards) { card in
                CardView(card: card)
                    .onTapGesture() {
                        withAnimation(.linear) {
                            gameViewModel.choose(card: card)
                        }
                    }
                    .aspectRatio(contentMode:.fit)
                    .padding(5.0)
            }
            .padding()
            .foregroundColor(themeModel.selectedTheme.color)
            Button(action: {
                withAnimation(.easeInOut) {
                    themeModel.switchToRandomTheme()
                    gameViewModel.newMemoryGame(theme: themeModel.selectedTheme)
                }
            }, label: {
                Text("New Game")
            })
            HStack {
                Text("Theme: \(themeModel.selectedTheme.name)").padding()
                Image(systemName: "pencil.circle.fill")
            }
            .onTapGesture {
                themePickerShowing = true
            }
            .sheet(isPresented: $themePickerShowing, onDismiss: {
                checkForChangeOfSelectedTheme()
            }) {
                EmojiMemoryThemePicker(isBeingPresented: $themePickerShowing)
                    .environmentObject(themeModel)
            }
        }.font(Font.system(size: 32))
        .padding()
    }
    
    func checkForChangeOfSelectedTheme() {
        if (gameViewModel.theme != themeModel.selectedTheme) {
            gameViewModel.newMemoryGame(theme: themeModel.selectedTheme)
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
        let gameModel = EmojiMemoryGame()
        let themeModel = EmojiMemoryGameThemeViewModel()
        gameModel.choose(card: gameModel.cards[0])
        return EmojiMemoryGameView(gameViewModel: gameModel, themeModel: themeModel)
    }
}
