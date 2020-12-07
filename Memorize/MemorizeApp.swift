//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Eli Manjarrez on 9/23/20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            let themes = EmojiMemoryGameThemeViewModel()
            let game = EmojiMemoryGame(theme:themes.selectedTheme)
            EmojiMemoryGameView(gameViewModel: game, themeModel: themes)
        }
    }
}
