//
//  CoordinatorView.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//

import SwiftUI

struct CoordinatorView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
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
        }
        .sheet(item: $coordinator.sheet) { sheet in
            switch sheet {
            case .createEvent:
                coordinator.build(sheet: sheet)
            case .shared:
                coordinator.build(sheet: sheet)
            case .editIvent(let iventmodel):
                coordinator.build(sheet: sheet, iventModel: iventmodel)
            case .shareUseActivityVC(let event):
                coordinator.build(sheet: sheet, iventModel: event)
            case .shareByQRCode(let event):
                coordinator.build(sheet: sheet, iventModel: event)
            case .createEventFromQR(let encodeString):
                coordinator.build(sheet: sheet, encodeString: encodeString)
            }
        }
    }
}


#Preview {
    CoordinatorView()
        .environmentObject(Coordinator())
}
