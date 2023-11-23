//
//  Coordinator.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//

import SwiftUI

class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath() 
    @Published var sheet: Sheets?
    @EnvironmentObject var viewModel: EventViewModel
    
    
    func push(page: Page) {
        path.append(page)
    }
    
    func present(sheet: Sheets) {
        self.sheet = sheet
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func addIvent(ivent: IventModel) {
        viewModel.appendEvent(event: ivent)
    }
    
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .content:
            ContentView()
        case .eventsList:
            EventListView()
        }
    }
    
    @ViewBuilder
    func build(sheet: Sheets, iventModelIndex: IventModel) -> some View {
        EditEvents(iventModel: iventModelIndex)
    }
    
    @ViewBuilder
    func build(sheet: Sheets) -> some View {
        if sheet == .shared {
            SharedView()
        } else if sheet == .createEvent {
            CreateEventsView()
        }
    }
}
