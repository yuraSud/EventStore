//
//  EventListView.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//
import SwiftData
import SwiftUI
import Observation

struct EventListView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var viewModel: EventViewModel
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 24, weight: .semibold),
        ]
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        VStack(spacing: 10) {
            
            PeriodButtonsPicker(selectedIndexButton: $viewModel.selectedIndexButton, isDatePickerPresent: $viewModel.isDatePickerPresent)
            
            if viewModel.selectedIndexButton == .custom && viewModel.isDatePickerPresent {
                DatePicker("", selection: $viewModel.selectDate, in: Date()...)
                    .datePickerStyle(.graphical)
            }
            
            QueryListView()
                .navigationTitle("My Events")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Menu{
                            Button(action: {
                                coordinator.present(sheet: .shared)
                            }, label: {
                                Label("Scan QRCode", systemImage: "qrcode.viewfinder")
                            })
                            
                            Button(action: {
                                viewModel.getAllEventsFromCalendar()
                            }, label: {
                                Label("Get events from Calendar", systemImage: "ellipsis.circle")
                            })
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .foregroundStyle(.indigo)
                        }
                        
                    }
                }
            
                .toolbar {
                    ToolbarItem (placement: .topBarTrailing) {
                        Button(action: {
                            coordinator.present(sheet: .createEvent)
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundStyle(Color.indigo)
                        })
                    }
                }
        }
        .padding()
    }
}
//#Preview {
//    NavigationStack {
//        EventListView()
//            .environmentObject(Coordinator())
//            .environmentObject(EventListViewModel())
//    }
//}
