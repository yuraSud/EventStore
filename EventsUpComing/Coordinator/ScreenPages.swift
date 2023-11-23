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
    case editIvent(IventModel)
    
    var id: Self {
        self
    }
}
