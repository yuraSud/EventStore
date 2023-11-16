//
//  CoordinatorView.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//

import SwiftUI

struct CoordinatorView: View {
    @State var arrayIvents: [IventModel] = [
        IventModel(title: "Ivent"),
        IventModel(title: "Ivent two"),
        IventModel(title: "Ivent three", notes: "Soon meet"),
    ]
    @StateObject var eventsViewModel = EventListViewModel()
    @StateObject var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .eventsList)
                .navigationDestination(for: Page.self) { page in
                    switch page {
                    case .eventsList:
                        coordinator.build(page: page)
                    case .content:
                        coordinator.build(page: page)
                    }
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    switch sheet {
                    case .createEvent:
                        coordinator.build(sheet: sheet)
                    case .shared:
                        coordinator.build(sheet: sheet)
                    case .editIvent(let iventmodel):
                        coordinator.build(sheet: sheet, iventModel: iventmodel)
                    }
                }
                .onAppear{
                    eventsViewModel.arrayIvents = arrayIvents
                }
        }
        .environmentObject(coordinator)
        .environmentObject(eventsViewModel)
    }
}

#Preview {
    CoordinatorView()
        .environmentObject(Coordinator())
}
