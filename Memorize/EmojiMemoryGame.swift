//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Eli Manjarrez on 9/23/20.
//

import SwiftUI

class EmojiMemoryGame : ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["🇧🇮","🇧🇪","🇨🇻","🇨🇴","🇦🇹","🇧🇭","🇦🇶","🇦🇱","🇨🇬"]
        var theseEmojis = emojis
        theseEmojis.shuffle()
        let numPairs = Int.random(in: 2...5)
        return MemoryGame<String>(numberOfPairsOfCards: numPairs) { pairIndex in
            theseEmojis[pairIndex]
        }
    }
    
    // MARK: -  Access to the model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
 
    // MARK: - Intents
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
