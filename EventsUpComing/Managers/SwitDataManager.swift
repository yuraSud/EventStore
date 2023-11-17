//
//  SwitDataMaager.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 16.11.2023.
//

import SwiftUI
import SwiftData

final class SwitDataManager: ObservableObject {
    
    var modelContext: ModelContext
    @Published var events: [IventModel] = []
    
    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchIvents()
    }
    
    func fetchIvents() {
        
        do {
            let descriptor = FetchDescriptor<IventModel>(sortBy: [SortDescriptor(\.date)])
            let events = try modelContext.fetch(descriptor)
            print("users count = ", events.count)
            self.events = events
        } catch {
            print("Fetch Failed")
        }
    }
    
    func createNewEvent(event: IventModel) {
        modelContext.insert(event)
    }
    
    func deleteUser(event: IventModel) {
        modelContext.delete(event)
    }
    
}
