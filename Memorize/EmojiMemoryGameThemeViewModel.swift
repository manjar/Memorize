//
//  EmojiMemoryGameThemeViewModel.swift
//  Memorize
//
//  Created by Eli Manjarrez on 12/6/20.
//

import Foundation
import Combine

class EmojiMemoryGameThemeViewModel: ObservableObject
{
    @Published var themes: Array<EmojiMemoryGameTheme>
    @Published var selectedTheme: EmojiMemoryGameTheme
//    private var autosaveCancellable: AnyCancellable?
    
    init() {
//        let defaultsKey = "EmojiGameThemese"
        themes = EmojiMemoryGameTheme.allThemes()
        selectedTheme = EmojiMemoryGameTheme.allThemes()[Int.random(in: 0..<EmojiMemoryGameTheme.allThemes().count)]
        //        themes = Array(json: UserDefaults.standard.data(forKey: defaultsKey)) ?? EmojiMemoryGameTheme.allThemes()
//        autosaveCancellable = themes.sink { emojiArt in
//            UserDefaults.standard.set(themes.json, forKey: defaultsKey)
//        }
    }
    
    func themeMatchingTheme(_ theme:EmojiMemoryGameTheme) -> EmojiMemoryGameTheme {
        themes[themes.firstIndex(matching: theme)!]
    }
    
    func switchToRandomTheme() {
        selectedTheme = themes[Int.random(in: 0..<themes.count)]
    }
    
    func updateTheme(_ theme:EmojiMemoryGameTheme, toName name:String) {
        themes[themes.firstIndex(matching: theme)!].name = name
    }
    
    func updateTheme(_ theme:EmojiMemoryGameTheme, toThemeColor themeColor:EmojiMemoryGameThemeColor) {
        themes[themes.firstIndex(matching: theme)!].themeColor = themeColor
    }
    
    func updateTheme(_ theme:EmojiMemoryGameTheme, byAddingEmojis emojisToAdd: String) {
        for character in emojisToAdd {
            themes[themes.firstIndex(matching: theme)!].emojis.append(String(character))
        }
    }
    
    func updateTheme(_ theme:EmojiMemoryGameTheme, byRemovingEmoji emojiToRemove: String) {
        if let themeIndex = themes.firstIndex(matching: theme) {
            if let emojiIndex = themes[themeIndex].emojis.firstIndex(of: emojiToRemove) {
                themes[themeIndex].emojis.remove(at: emojiIndex)
            }
        }
    }
}
