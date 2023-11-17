//
//  CreateEventsView.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//

import SwiftUI

struct CreateEventsView: View {
    
    @Environment(\.modelContext) var context
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var viewModel: EventListViewModel
    var title: String {
        viewModel.title.isEmpty ? "New Title" : viewModel.title
    }
    
    var body: some View {
        VStack {
            HStack {
                Button("Cancel", action: coordinator.dismissSheet)
                
                Spacer()
                
                Text(title).font(.headline)
                
                Spacer()
                
                Button("Add", action: saveIvent)
                    .disabled(!viewModel.newEventIsDisable)
                
                
            }.padding(.horizontal)
            
            Divider().padding(.horizontal)
            
            Form {
                EventEditorView(title: $viewModel.title, note: $viewModel.notes, date: $viewModel.date)
            }
            .shadow(radius: 10)
            .scrollContentBackground(.hidden)
        }
        .padding()
    }
    
    func saveIvent() {
//        let newIvent = IventModel(title: viewModel.title, notes: viewModel.notes, date: viewModel.date)
//        context.insert(newIvent)
        viewModel.addIvent()
        coordinator.dismissSheet()
    }
    
    func addIvent() {
//        let newIvent = IventModel(title: viewModel.title, notes: viewModel.notes, date: viewModel.date)
//        context.insert(newIvent)
//        arrayIvents.append(newIvent)
    }
}

//#Preview {
//    
//    CreateEventsView()
//        .environmentObject(Coordinator())
//        .environmentObject(EventListViewModel())
//}
