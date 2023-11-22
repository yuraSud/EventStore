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
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
        }
        .environmentObject(eventsViewModel)
    }
}
