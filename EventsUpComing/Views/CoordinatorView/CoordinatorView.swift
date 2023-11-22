//
//  CoordinatorView.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//

import SwiftUI

struct CoordinatorView: View {

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
                    case .editIvent(let iventmodelIndex):
                        coordinator.build(sheet: sheet, iventModelIndex: iventmodelIndex)
                    }
                }
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    CoordinatorView()
        .environmentObject(Coordinator())
}
