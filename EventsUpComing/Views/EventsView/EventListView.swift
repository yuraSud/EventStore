//
//  EventListView.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//
import SwiftData
import SwiftUI

struct EventListView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var viewModel: EventListViewModel
    //    @Query(filter: #Predicate<IventModel>{
    //        let dateNow = Date.now
    //        $0.date > dateNow && $0.date <= viewModel.endDate},
    //           sort: \IventModel.date, order: .forward, animation: .smooth)
    //        var events: [IventModel]
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 24, weight: .semibold),
        ]
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        // _events = Query(filter: IventModel.currentPredicate(to: endDate),
        //             sort: \IventModel.date, order: .forward, animation: .spring)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            
            PeriodButtonsPicker(selectedIndex: $viewModel.selectedIndexButton, isDatePickerPresent: $viewModel.isDatePickerPresent)
            
            if viewModel.selectedIndexButton == .custom && viewModel.isDatePickerPresent {
                DatePicker("", selection: $viewModel.selectDate, in: Date()...)
                    .datePickerStyle(.graphical)
            }
            
            QueryListView(viewModel: viewModel)
                .navigationTitle("My Events")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            coordinator.present(sheet: .shared)
                        }, label: {
                            Image(systemName: "line.3.horizontal")
                                .foregroundStyle(Color.indigo)
                        })
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
