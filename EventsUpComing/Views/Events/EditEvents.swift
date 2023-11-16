//
//  EditEvents.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 15.11.2023.
//

import SwiftUI

struct EditEvents: View {
   
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var viewModel: EventListViewModel
    @Binding var iventModel: IventModel
    @State var isEventChanged = false
    
    var body: some View {
        VStack {
            HStack {
                Button("Cancel", action: coordinator.dismissSheet)
                
                Spacer()
                
                Text(iventModel.title).font(.headline)
                
                Spacer()
                
                Button("Save", action: saveIvent)
                    .disabled(!isEventChanged)
                
                
            }.padding(.horizontal)
            
            Divider().padding(.horizontal)
            
            TextField("name", text: $iventModel.title)
            
            Form {
                EventEditorView(title: $iventModel.title, note: $iventModel.notes, date: $iventModel.date)
            }
            .shadow(radius: 10)
            .scrollContentBackground(.hidden)
        }
//        .onChange(of: $iventModel, { oldValue, newValue in
//            isEventChanged = true
//        })
        .padding()
    }
    
    func saveIvent() {
       // viewModel.addIvent()
        coordinator.dismissSheet()
    }
}

#Preview {
    EditEvents(iventModel: .constant(IventModel(title: "Yura", notes: "Meet soon")))
        .environmentObject(Coordinator())
        .environmentObject(EventListViewModel())
}
