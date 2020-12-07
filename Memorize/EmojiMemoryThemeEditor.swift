//
//  EmojiMemoryThemeEditor.swift
//  Memorize
//
//  Created by Eli Manjarrez on 12/6/20.
//

import SwiftUI

struct EmojiMemoryThemeEditor: View {
    @EnvironmentObject var themeModel: EmojiMemoryGameThemeViewModel
    var themeBeingEdited: EmojiMemoryGameTheme
    @State private var emojisToAdd: String = ""
    @State private var cardCount: Int = 0
    @State private var themeName: String = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Theme Name", text: $themeName, onEditingChanged: { began in
                    themeModel.updateTheme(themeBeingEdited, toName: themeName)
                })
            }
            Section(header: Text("Add Emoji"), content: {
                TextField("Add Emoji", text: $emojisToAdd, onEditingChanged: { began in
                    themeModel.updateTheme(themeBeingEdited, byAddingEmojis: emojisToAdd)
                    self.emojisToAdd = ""
                })
            })
            Section(header: Text("Remove Emoji")) {
                Grid(themeModel.themeMatchingTheme(themeBeingEdited).emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            themeModel.updateTheme(themeBeingEdited, byRemovingEmoji:emoji)
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
                    EmojiMemoreThemeEditorColorCell(color: EmojiMemoryGameTheme.systemColor(for: themeColor), isSelected: themeColor == themeModel.themeMatchingTheme(themeBeingEdited).themeColor)
                        .onTapGesture {
                            themeModel.updateTheme(themeBeingEdited, toThemeColor: themeColor)
                        }
                }
            }
        }.onAppear {
            themeName = themeBeingEdited.name
        }
        .navigationBarTitle(themeName)
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
