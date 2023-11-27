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
    
    var model: IventModel?
    var isFromQRCode: Bool {
        didSet {
            print(isFromQRCode, "isQR")
        }
    }
    
    init(model: IventModel? = nil, isFromQRCode: Bool = false) {
        self.isFromQRCode = isFromQRCode
        self.model = model
    }

    
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
                
                
            }.padding(.horizontal)
            
            Divider().padding(.horizontal)
            
            Form {
                EventEditorView(title: $viewModel.title, note: $viewModel.notes, date: $viewModel.date)
            }
            .shadow(radius: 10)
            .scrollContentBackground(.hidden)
        }
        .padding()
        .onAppear {
            if isFromQRCode {
                if let model = model {
                    viewModel.eventFromQR(event: model)
                }
            }
        }
    }
    
    func addEventFromQRCode() {
        
        if isFromQRCode {
            
            viewModel.addNewIvent()
        }
    }
}

//#Preview {
//    
//    CreateEventsView()
//        .environmentObject(Coordinator())
//        .environmentObject(EventListViewModel())
//}
