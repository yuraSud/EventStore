//
//  EventKitViewModel.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 18.11.2023.
//
import EventKit
import SwiftUI


class EventKitViewModel {
    
    let eventStore = EKEventStore()
    var eventsFromCalendar: [IventModel] = []
    
    init() {
        fetchEventsFromCalendar()
    }
    
    func fetchEventsFromCalendar() -> Void {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        switch status {
        case .notDetermined: requestAccessToCalendar()
        case .authorized: insertEventsFromCalendar()
        case .denied: print("Access denied")
        default: break
        }
    }
    
    func requestAccessToCalendar() {
        eventStore.requestFullAccessToEvents(completion: { _, _ in
            self.insertEventsFromCalendar()
        })
    }
    
    func insertEventsFromCalendar() -> Void {
        eventsFromCalendar = []
        let start = Date.now
        let endDate = start.addOneMounth()

        let predicate = eventStore.predicateForEvents(withStart: start, end: endDate, calendars: nil)
       
        let eventsArray = eventStore.events(matching: predicate)
        
        for event in eventsArray {
            let title = event.title ?? "Not title"
            let date = event.startDate as Date
            let description = ""
            
            let newEvent = IventModel(title: title, notes: description, date: date)
           
            eventsFromCalendar.append(newEvent)
        }
    }
}
    

