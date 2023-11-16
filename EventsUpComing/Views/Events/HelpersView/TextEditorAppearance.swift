//
//  TextEditorAppearance.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 16.11.2023.
//

import SwiftUI

struct TextEditorAppearance: View {
    
    @Binding var text: String
    
    //  let placeholder = "Notes"
    var placeholder: String {
        //text.isEmpty ? "Notes" : text
        "Notes"
    }
    
    init(textInTextEditor: Binding<String>) {
        UITextView.appearance().backgroundColor = .clear
        _text = textInTextEditor
    }
    
    var body: some View {
        VStack {
            TextEditor(text: $text)
                .multilineTextAlignment(.leading)
                .background(
                    HStack(alignment: .top) {
                        text.isEmpty ? Text(placeholder) : Text("")
                        Spacer()
                    }
                        .foregroundColor(Color.primary.opacity(0.25))
                        .padding(EdgeInsets(top: -8, leading: 6, bottom: 7, trailing: 0))
                )
        }
    }
}
