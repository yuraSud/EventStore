//
//  HeaderList.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 14.11.2023.
//

import SwiftUI

struct HeaderList: View {
    
    var headerTitle: String
    
    var body: some View {
        HStack {
            Text(headerTitle)
                .font(.Inter.inter(.semibold, size: 20))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    HeaderList(headerTitle: "May 31 - Jun, 2023")
}
