//
//  EventListViewModel.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//

import SwiftUI

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

class EventListViewModel: ObservableObject {
    
    @Published var selectedIndexButton: Period = .week 
    @Published var arrayIvents: [IventModel] = [
        
    ]
    @Published var headerTitle = "May 31 - Jun, 2023"
    @Published var selectDate: Date = Date()
   
    @Published var title = ""
    @Published var notes = ""
    @Published var date = Date()
    var addIsDisabled: Bool {
        true
    }
    
    func addIvent() {
        let newIvent = IventModel(title: title, notes: notes, date: date)
        arrayIvents.append(newIvent)
    }
    
    func deleteIvent(indexSet: IndexSet) {
        for index in indexSet {
            arrayIvents.remove(at: index)
        }
    }
    
}
