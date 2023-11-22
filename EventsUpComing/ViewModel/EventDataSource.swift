//
//  EventDataSource.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 22.11.2023.
//
import SwiftData
import SwiftUI

final class EventDataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = EventDataSource()

    @MainActor
    private init() {
        let schema = Schema([
            IventModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            self.modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            self.modelContext = modelContainer.mainContext
            
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    func appendIvent(ivent: IventModel) {
        modelContext.insert(ivent)
//        do {
//            try modelContext.save()
//        } catch {
//            fatalError(error.localizedDescription)
//        }
    }

    func fetchIvents() -> [IventModel] {
        do {
            return try modelContext.fetch(FetchDescriptor<IventModel>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func removeIvent(_ ivent: IventModel) {
        modelContext.delete(ivent)
    }
}
