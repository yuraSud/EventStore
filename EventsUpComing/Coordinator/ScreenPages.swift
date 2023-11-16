//
//  ScreenPages.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//

import SwiftUI

enum Page: Hashable, Equatable {
    case eventsList
    case content
}

enum Sheets: Hashable, Equatable, Identifiable {
    
    static func == (lhs: Sheets, rhs: Sheets) -> Bool {
        switch (lhs, rhs) {
        case (.createEvent, .createEvent), (.shared, .shared):
            return true
        case (.editIvent, .editIvent):
            return true
        default:
            return false
        }
    }
    
    case createEvent
    case shared
    case editIvent(Binding<IventModel>)
    
    var id: Self {
        self
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .createEvent:
            hasher.combine(0)
        case .shared:
            hasher.combine(1)
        case let .editIvent(binding):
            hasher.combine(binding.wrappedValue)
        }
    }
}
