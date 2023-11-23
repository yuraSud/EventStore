//
//  EditEvents.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 15.11.2023.
//
import SwiftData
import SwiftUI

struct EditEvents: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var viewModel: EventViewModel
  //  var index: Int
    @State var isEventChanged = false
    @State var model: IventModel//(title: "")
    
    
//    init(iventModelIndex: Int) {
//        self.index = iventModelIndex
//    }
    
    init(iventModel: IventModel) {
        _model = State(initialValue: iventModel)
    }
    
    var body: some View {
        VStack {
            HStack {
                Button("Delete", action: deleteEvent)
                
                Spacer()
                
                Text(model.title).font(.headline)
                
                Spacer()
                
                Button("Ok", action: coordinator.dismissSheet)
                   
            }.padding(.horizontal)
            
            Divider().padding(.horizontal)
            
            Form {
                EventEditorView(title: $model.title, note: $model.notes, date: $model.date)
            }
            .shadow(radius: 10)
            .scrollContentBackground(.hidden)
        }
        .padding()
        .onAppear{
          //  self.model = viewModel.events[index]
        }
    }
    
    func deleteEvent() {
        viewModel.removeEvent(model)
        coordinator.dismissSheet()
    }
}

//#Preview {
//    EditEvents(iventModelIndex: 2)
//        .environmentObject(Coordinator())
//        .environmentObject(EventListViewModel())
//}
