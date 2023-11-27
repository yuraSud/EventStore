//
//  Period.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//
import Combine
import SwiftUI
import SwiftData


enum Period: Int, CaseIterable, Identifiable {
    case week
    case month
    case year
    case custom
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .week: "Week"
        case .month: "Month"
        case .year: "Year"
        case .custom: "Custom"
        }
    }
}
