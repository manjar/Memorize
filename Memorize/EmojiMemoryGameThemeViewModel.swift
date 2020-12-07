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
    @Published var selectedTheme: EmojiMemoryGameTheme?
//    private var autosaveCancellable: AnyCancellable?
    
    init() {
//        let defaultsKey = "EmojiGameThemese"
        themes = EmojiMemoryGameTheme.allThemes()
        selectedTheme = themes[Int.random(in: 0..<themes.count)]
        //        themes = Array(json: UserDefaults.standard.data(forKey: defaultsKey)) ?? EmojiMemoryGameTheme.allThemes()
//        autosaveCancellable = themes.sink { emojiArt in
//            UserDefaults.standard.set(themes.json, forKey: defaultsKey)
//        }
    }
    
    func newTheme() {
        selectedTheme = themes[Int.random(in: 0..<themes.count)]
    }
}
