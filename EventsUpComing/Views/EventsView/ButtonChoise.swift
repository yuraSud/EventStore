//
//  ButtonChoise.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//

import SwiftUI

struct ButtonChoise: View {
    
    var title: String
    var isTaped: Bool
    
    var body: some View {
        Text(title)
            .font(.Inter.inter(.regular, size: 16))
            .frame(height: 48)
            .frame(maxWidth: .infinity)
            .foregroundColor(isTaped ? .white : .black)
            .background(isTaped ? Color.indigo :  Color.buttonMain)
            .clipShape(.rect(cornerRadius: 15), style: .init())
    }
}

#Preview {
    ButtonChoise(title: "Week", isTaped: false)
}
