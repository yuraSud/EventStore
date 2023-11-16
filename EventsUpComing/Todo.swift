//
//  Item.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//

import Foundation
import SwiftData

@Model
final class Todo {
    var creationDate: Date
    var title: String?
    var toDoDescription: String?
    
    
    init(creationDate: Date, title: String? = "Yura", description: String? = nil) {
        self.creationDate = creationDate
        self.title = title
        self.toDoDescription = description
    }
}
