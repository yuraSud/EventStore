//
//  EventEditorView.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 16.11.2023.
//

import SwiftUI

struct EventEditorView: View {
   
    @Binding var title: String
    @Binding var note: String
    @Binding var date: Date
    
    var body: some View {
            VStack (alignment: .leading, spacing: 14) {
                TextField("Title", text: $title)
                Divider()
                
                TextEditorAppearance(textInTextEditor: $note)
                
                Divider()
                DatePicker("Choise date:", selection: $date, in: Date()..., displayedComponents: .date)
                    .padding([.bottom, .trailing])
            }
            .autocorrectionDisabled()
            .padding()
    }
}

#Preview {
    EventEditorView(title: .constant("Meet"), note: .constant("Don't forgot, you need meet with Olya. \n In SpringCity"), date: .constant(.now))
}
