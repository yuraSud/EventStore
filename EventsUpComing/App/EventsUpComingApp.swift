//
//  EventsUpComingApp.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//

import SwiftUI
import SwiftData

@main
struct EventsUpComingApp: App {
    let container: ModelContainer
    @StateObject var eventsViewModel: EventListViewModel
    
    init() {
        let schema = Schema([
            IventModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            let viewModel = EventListViewModel(context: container.mainContext)
            _eventsViewModel = StateObject(wrappedValue: viewModel)
            
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
        }
        .modelContainer(container)
        .environmentObject(eventsViewModel)
        
    }
}
