//
//  EventCell.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 14.11.2023.
//

import SwiftUI

struct EventCell: View {
    
    @Binding var ivent : IventModel
    
    var body: some View {
        HStack {
            Text(ivent.title)
            Spacer()
            Text(ivent.date.description)  //TODO: добавить расчет времени от сегодняшней даты до даты запланированной
                .foregroundStyle(.indigo)
        }
        .padding(.horizontal)
        .contentShape(Rectangle())
        .font(.Inter.inter(.regular, size: 17))
        .frame(height: 48)
        .frame(maxWidth: .infinity)
        .background(Color.cell)
        .listRowSeparator(.hidden)
    }
}

#Preview {
    EventCell(ivent: .constant(IventModel(title: "Ivent")))
}
