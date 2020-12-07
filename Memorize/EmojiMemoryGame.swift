//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Eli Manjarrez on 9/23/20.
//

import SwiftUI

class EmojiMemoryGame : ObservableObject {
    var theme: EmojiMemoryGameTheme?
    @Published private var model: MemoryGame<String>
    
    init(theme: EmojiMemoryGameTheme? = nil) {
        self.theme = theme
        if theme != nil {
            model = EmojiMemoryGame.createMemoryGame(theme: theme)
        } else {
            model = EmojiMemoryGame.createMemoryGame()
        }
    }
    
    private static func createMemoryGame(theme: EmojiMemoryGameTheme? = nil) -> MemoryGame<String> {
        var themeToUse = theme ?? EmojiMemoryGameTheme.randomTheme()
        print("json representation is: \(themeToUse.json?.utf8 ?? "nil")")
        themeToUse.emojis.shuffle()
        return MemoryGame<String>(numberOfPairsOfCards: themeToUse.numberOfPairs) { pairIndex in
            themeToUse.emojis[pairIndex]
        }
    }
    
    func newMemoryGame(theme: EmojiMemoryGameTheme? = nil) {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    // MARK: -  Access to the model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
 
    // MARK: - Intents
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
