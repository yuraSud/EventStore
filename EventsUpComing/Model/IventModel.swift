//
//  CellModel.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 14.11.2023.
//

import SwiftUI
import SwiftData

@Model
final class IventModel: Identifiable, Hashable, Equatable {
    var title: String
    var notes: String
    var date: Date
    var id = UUID()

    init(title: String, notes: String = "", date: Date = .now, id: UUID = UUID()) {
        self.title = title
        self.notes = notes
        self.date = date
        self.id = id
    }
    
    static func currentPredicate(to date: Date) -> Predicate<IventModel> {
        let currentDate = Date.now
        
        return #Predicate<IventModel> { event in
            event.date > currentDate && event.date <= date
        }
    }
}
