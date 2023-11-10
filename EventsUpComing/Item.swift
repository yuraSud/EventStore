//
//  Item.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
