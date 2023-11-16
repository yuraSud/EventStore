//
//  CellModel.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 14.11.2023.
//

import Foundation

struct IventModel: Identifiable, Hashable, Equatable {
    var title: String
    var notes: String = ""
    var date: Date = .now
    var id = UUID()
}
