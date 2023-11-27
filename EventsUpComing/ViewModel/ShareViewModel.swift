//
//  ShareViewModel.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 26.11.2023.
//

import SwiftUI

class ShareViewModel: ObservableObject {
    
    func transformEventToString(event: IventModel) -> String {
        
        var eventString = "Topic: \(event.title)"
        
        if !event.notes.isEmpty {
            eventString.append("\nNotes: \(event.notes)")
        }
        
        eventString.append("\n\ndate: \(event.date.dateToString)")
        return eventString
    }
}
