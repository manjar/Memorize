//
//  EmojiMemoryGameTheme.swift
//  Memorize
//
//  Created by Eli Manjarrez on 12/6/20.
//

import Foundation
import SwiftUI

enum EmojiMemoryGameThemeType: String, CaseIterable, Codable {
    case halloween
    case faces
    case sports
    case flags
    case foods
    case animals
}

enum EmojiMemoryGameThemeColor: String, CaseIterable, Codable {
    case orange
    case pink
    case blue
    case gray
    case green
    case yellow
}

struct EmojiMemoryGameTheme: Codable, Identifiable, Equatable, Hashable {
    var id: EmojiMemoryGameThemeType
    var emojis: Array<String> = ["👻","🦇","🧛🏻‍♂️","🎃","🕷","🕸","🙀","😱","🔥"]
    var themeColor: EmojiMemoryGameThemeColor = .blue
    var name: String
    
    var color: Color {
        EmojiMemoryGameTheme.systemColor(for: themeColor)
    }
    
    static func systemColor(for themeColor: EmojiMemoryGameThemeColor) -> Color {
        switch themeColor {
        case .orange:
            return Color.orange
        case .pink:
            return Color.pink
        case .blue:
            return Color.blue
        case .gray:
            return Color.gray
        case .green:
            return Color.green
        case .yellow:
            return Color.yellow
        }
    }

    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    var numberOfPairs: Int {
        get {
            return emojis.count
        }
    }
    
    init() {
        self.init(withThemeType: EmojiMemoryGameThemeType.flags)
    }
    
    init(id: EmojiMemoryGameThemeType, emojis: Array<String>, themeColor:EmojiMemoryGameThemeColor, name: String) {
        self.id = id
        self.emojis = emojis;
        self.themeColor = themeColor
        self.name = name
    }
    
    init(withThemeType themeType: EmojiMemoryGameThemeType) {
        name = themeType.rawValue.capitalized
        id = themeType
        switch themeType {
        case .halloween:
            emojis = ["👻","🦇","🧛🏻‍♂️","🎃","🕷","🕸","🙀","😱","🔥"]
            themeColor = .orange
            break;
        case .faces:
            emojis = ["👩🏽‍🦰","👲🏿","🧛🏻‍♂️","👵🏾","🧑🏻‍🍳","👩🏽‍🌾","👩🏻‍💼"]
            themeColor = .pink
            break;
        case .sports:
            emojis = ["⚽️","🏀","🏈","⚾️","🥎","🏓","🎿","🏉","🥏"]
            themeColor = .blue
            break;
        case .flags:
            emojis = ["🇧🇮","🇧🇪","🇨🇻","🇨🇴","🇦🇹","🇧🇭","🇦🇶","🇦🇱","🇨🇬"]
            themeColor = .gray
            break;
        case .foods:
            emojis = ["🧀","🥬","🥐","🍖","🥨","🌮","🌽","🍩","🍤"]
            themeColor = .green
            break;
        case .animals:
            emojis = ["🐶","🐤","🐍","🦄","🐒","🦐","🐪","🦀","🦋"]
            themeColor = .yellow
            break;
        }
    }
    
    static func allThemes() -> Array<EmojiMemoryGameTheme> {
        var returnArray = Array<EmojiMemoryGameTheme>()
        for themeType in EmojiMemoryGameThemeType.allCases {
            returnArray.append(EmojiMemoryGameTheme(withThemeType: themeType))
        }
        return returnArray
    }
    
    static func randomTheme() -> EmojiMemoryGameTheme {
        let allThemes = EmojiMemoryGameThemeType.allCases.shuffled()
        return EmojiMemoryGameTheme(withThemeType:allThemes.first!)
    }
}
