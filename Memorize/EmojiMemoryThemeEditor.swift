//
//  EmojiMemoryThemeEditor.swift
//  Memorize
//
//  Created by Eli Manjarrez on 12/6/20.
//

import SwiftUI

struct EmojiMemoryThemeEditor: View {
    @Binding var theme: EmojiMemoryGameTheme
    @State private var emojisToAdd: String = ""
    @State private var cardCount: Int = 0
    
    var body: some View {
        Form {
            Section {
                TextField("Theme Name", text: $theme.name)
            }
            Section(header: Text("Add Emoji"), content: {
                TextField("Add Emoji", text: $emojisToAdd, onEditingChanged: { began in
                    for character in emojisToAdd {
                        theme.emojis.append(String(character))
                    }
                    self.emojisToAdd = ""
                })
            })
            Section(header: Text("Remove Emoji")) {
                Grid(theme.emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            theme.emojis.remove(at: theme.emojis.firstIndex(of: emoji)!)
                        }
                }
            }
            Section(header: Text("Card count")) {
                HStack {
                    Text("\(cardCount)")
                    Stepper(onIncrement: {
                        cardCount += 1
                    }, onDecrement: {
                        cardCount -= 1
                    }, label: { EmptyView() })
                }
            }
            Section(header: Text("Color")) {
                Grid(EmojiMemoryGameThemeColor.allCases, id: \.self) { themeColor in
                    EmojiMemoreThemeEditorColorCell(color: EmojiMemoryGameTheme.systemColor(for: themeColor), isSelected: themeColor == theme.themeColor)
                        .onTapGesture {
                            theme.themeColor = themeColor
                        }
                }
            }
        }
    }
}

struct EmojiMemoreThemeEditorColorCell: View {
    var color: Color
    var isSelected: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5.0)
                .foregroundColor(color)
            RoundedRectangle(cornerRadius: 5.0)
                .strokeBorder()
            if isSelected {
                Image(systemName: "checkmark.circle")
            }
        }.aspectRatio(1.0, contentMode: .fit)
    }
}
