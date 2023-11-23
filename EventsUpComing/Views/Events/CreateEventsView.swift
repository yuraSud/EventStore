//
//  CreateEventsView.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//

import SwiftUI

struct CreateEventsView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var viewModel: EventViewModel
    
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
                
                Button("Add") {
                    viewModel.addNewIvent()
                    coordinator.dismissSheet()
                }
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
}

//#Preview {
//    
//    CreateEventsView()
//        .environmentObject(Coordinator())
//        .environmentObject(EventListViewModel())
//}
