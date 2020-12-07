//
//  EmojiMemoryThemeEditor.swift
//  Memorize
//
//  Created by Eli Manjarrez on 12/6/20.
//

import SwiftUI

struct EmojiMemoryThemeEditor: View {
    @Binding var theme: EmojiMemoryGameTheme
    var body: some View {
        Form {
            Section {
                TextField("Theme Name", text: $theme.name)
            }
        }
    }
}

//struct EmojiMemoryThemeEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        EmojiMemoryThemeEditor()
//    }
//}
