//
//  QueryListView.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 17.11.2023.
//
import SwiftUI

struct QueryListView: View {
    
    @EnvironmentObject var viewModel: EventViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        
        List {
            Section(header: customHeader()) {
                ForEach( viewModel.events, id: \.self) { event in
                    EventCell(ivent: event)
                        .onTapGesture {
                            coordinator.present(sheet: .editIvent(event))
                        }
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                viewModel.removeEvent(event)
                            }
                        }
                }
            }
            .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
        }
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
    }
    
    @ViewBuilder
    private func customHeader() -> some View {
        HStack {
            Text(viewModel.headerTitle)
                .font(.Inter.inter(.semibold, size: 20))
                .foregroundStyle(.black)
                .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    QueryListView()
        .environmentObject(Coordinator())
        .environmentObject(EventViewModel())
}
