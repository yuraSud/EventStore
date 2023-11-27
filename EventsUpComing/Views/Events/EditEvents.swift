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
    @State var isEventChanged = false
    @State var model: IventModel
    
    init(iventModel: IventModel) {
        _model = State(wrappedValue: iventModel)
    }
    
    var body: some View {
        VStack {
            HStack {
                Button("Delete", action: deleteEvent)
                
                Spacer()
                
                Text(model.title).font(.headline)
                
                Spacer()
                
                Button("Save") {
                    coordinator.dismissSheet()
                }
                
            }.padding(.horizontal)
            
            Divider().padding(.horizontal)
            
            Form {
                EventEditorView(title: $model.title, note: $model.notes, date: $model.date)
            }
            .shadow(radius: 10)
            .scrollContentBackground(.hidden)
            
            Menu("Share") {
                Button {
                    coordinator.present(sheet: .shareUseActivityVC(model))
                } label: {
                    Label("Share as a string", systemImage: "square.and.arrow.up")
                }
                
                Button {
                    coordinator.present(sheet: .shareByQRCode(model))
                } label: {
                    Label("Share by QRCode", systemImage: "qrcode.viewfinder")
                }

            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    
    func deleteEvent() {
        viewModel.removeEvent(model)
        coordinator.dismissSheet()
    }
}

//#Preview {
//    EditEvents(iventModel: IventModel(title: "Yura"))
//}
