//
//  EmojiMemoryThemePicker.swift
//  Memorize
//
//  Created by Eli Manjarrez on 12/6/20.
//

import SwiftUI

struct EmojiMemoryThemePicker: View {
    @Binding var themes: Array<EmojiMemoryGameTheme>
    @Binding var selectedTheme: EmojiMemoryGameTheme?
    @Binding var isBeingPresented: Bool
    
    var body: some View {
        NavigationView {
            List {
                ForEach(themes, id: \.self) { theme in
                    NavigationLink(destination: EmojiMemoryThemeEditor(theme: $themes[themes.firstIndex(matching:theme)!])
                                    .navigationBarTitle(theme.name)
                    ) {
                        EmojiThemeView(name: theme.name, emojis: theme.emojis, color: theme.color)
                            .onTapGesture {
                                selectedTheme = theme
                                isBeingPresented = false
                            }
                    }
                }.onDelete { (indexSetToDelete) in
                    deleteThemes(indexSet: indexSetToDelete)
                }
            }.navigationBarTitle("Memorize")
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    func deleteThemes(indexSet: IndexSet) {
        indexSet.map { themes[$0] }.forEach { theme in
            themes.remove(at: themes.firstIndex(matching: theme)!)
        }
    }
}

struct EmojiThemeView: View {
    var name: String
    var emojis: Array<String>
    var color: Color
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 5.0).foregroundColor(color)
                .frame(width: 40.0)
            VStack(alignment: HorizontalAlignment.leading, spacing: 5.0) {
                Text(name)
                HStack {
                    ForEach(emojis.map { String($0) }, id: \.self) { emoji in
                        Text(emoji)
                    }
                }
            }
        }
    }
}

//struct EmojiMemoryThemePicker_Previews: PreviewProvider {
//    @State static var selectedTheme:EmojiMemoryGameTheme? = nil;
//    selectedTheme = EmojiMemoryGameTheme(withThemeType: EmojiMemoryGameThemeType.halloween)
//    @State static var themes = [ selectedTheme ]
//    @State static var isBeingPresented: Bool = true
//    static var previews: some View {
//        EmojiMemoryThemePicker(themes: $themes, selectedTheme: $selectedTheme, isBeingPresented: $isBeingPresented )
//    }
//}
