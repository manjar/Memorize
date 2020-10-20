//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Eli Manjarrez on 9/23/20.
//

import SwiftUI

enum EmojiMemoryGameThemeType: CaseIterable {
    case halloween
    case faces
    case sports
    case flags
    case foods
    case animals
}

struct EmojiMemoryGameTheme {
    var emojis: Array<String> = ["👻","🦇","🧛🏻‍♂️","🎃","🕷","🕸","🙀","😱","🔥"]
    var themeColor: Color = Color.blue
    
    var numberOfPairs: Int {
        get {
            return emojis.count
        }
    }
    
    init() {
        self.init(withThemeType: EmojiMemoryGameThemeType.flags)
    }
    
    init(emojis: Array<String>, themeColor:Color) {
        self.emojis = emojis;
        self.themeColor = themeColor
    }
    
    init(withThemeType themeType: EmojiMemoryGameThemeType) {
        switch themeType {
        case .halloween:
            emojis = ["👻","🦇","🧛🏻‍♂️","🎃","🕷","🕸","🙀","😱","🔥"]
            themeColor = Color.orange
            break;
        case .faces:
            emojis = ["👩🏽‍🦰","👲🏿","🧛🏻‍♂️","👵🏾","🧑🏻‍🍳","👩🏽‍🌾","👩🏻‍💼"]
            themeColor = Color.pink
            break;
        case .sports:
            emojis = ["⚽️","🏀","🏈","⚾️","🥎","🏓","🎿","🏉","🥏"]
            themeColor = Color.blue
            break;
        case .flags:
            emojis = ["🇧🇮","🇧🇪","🇨🇻","🇨🇴","🇦🇹","🇧🇭","🇦🇶","🇦🇱","🇨🇬"]
            themeColor = Color.gray
            break;
        case .foods:
            emojis = ["🧀","🥬","🥐","🍖","🥨","🌮","🌽","🍩","🍤"]
            themeColor = Color.green
            break;
        case .animals:
            emojis = ["🐶","🐤","🐍","🦄","🐒","🦐","🐪","🦀","🦋"]
            themeColor = Color.yellow
            break;
        }
    }
}

class EmojiMemoryGame : ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let allThemes = EmojiMemoryGameThemeType.allCases.shuffled()
        var theme = EmojiMemoryGameTheme(withThemeType:allThemes.first!)
        theme.emojis.shuffle()
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            theme.emojis[pairIndex]
        }
    }
    
    func newMemoryGame() {
        model = EmojiMemoryGame.createMemoryGame()
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
