//
//  EventListView.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//

import SwiftUI

struct EventListView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var viewModel: EventListViewModel
    
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
            
            PeriodButtonsPicker(selectedIndex: $viewModel.selectedIndexButton)
            
            if viewModel.selectedIndexButton == .custom {
                
                DatePicker("", selection: $viewModel.selectDate)
                    .datePickerStyle(.graphical)
            }
            
            List {
                Section(header: customHeader()) {
                    ForEach($viewModel.arrayIvents) { item in
                        EventCell(ivent: item)
                            .onTapGesture {
                                coordinator.present(sheet: .editIvent(item))
                            }
                    }
                    .onDelete(perform: viewModel.deleteIvent)
                }
                .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
        }
        .padding()
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
}


#Preview {
    NavigationStack {
        EventListView()
            .environmentObject(Coordinator())
            .environmentObject(EventListViewModel())
    }
}
