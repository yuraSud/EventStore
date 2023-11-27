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
   
    @StateObject var eventsViewModel = EventViewModel()
    @StateObject var coordinator = Coordinator()
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .alert("Warning", isPresented: $coordinator.isShowAlert) {
                    Button ("Ok") { coordinator.errorMessage = "" }
                } message: {
                    Text(coordinator.errorMessage)
                }
        
        }
        .environmentObject(eventsViewModel)
        .environmentObject(coordinator)
    }
}
