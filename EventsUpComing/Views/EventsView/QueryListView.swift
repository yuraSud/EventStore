//
//  QueryListView.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 17.11.2023.
//
import SwiftData
import SwiftUI

struct QueryListView: View {
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.modelContext) var context
    @Query var events: [IventModel]
    let viewModel: EventListViewModel
    
    init(viewModel: EventListViewModel) {
        self.viewModel = viewModel
        _events = Query(filter: IventModel.currentPredicate(to: viewModel.endDate),
                        sort: \IventModel.date, order: .forward, animation: .spring)
        
    }
    
    var body: some View {
        
        List {
            Section(header: customHeader()) {
                ForEach( 0..<events.count, id: \.self) { index in
                    EventCell(ivent: events[index])
                        .onTapGesture {
                            coordinator.present(sheet: .editIvent(index))
                        }
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                context.delete(events[index])
                            }
                        }
                }
            }
            .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
        }
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
        
        .onChange(of: events) { oldValue, newValue in
            viewModel.events = self.events
        }
    }
    
    @ViewBuilder
    func customHeader() -> some View {
        HStack {
            Text(viewModel.headerTitle)
                .font(.Inter.inter(.semibold, size: 20))
                .foregroundStyle(.black)
                .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func delete(at offsets: IndexSet) {
        for i in offsets.makeIterator() {
            let theItem = events[i]
            context.delete(theItem)
        }
    }
}


//#Preview {
//    QueryListView()
//}
