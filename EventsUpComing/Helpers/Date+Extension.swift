//
//  Date+Extension.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 16.11.2023.
//

import Foundation

extension Date {
    
    func distance(from date: Date, only component: Calendar.Component, calendar: Calendar = .current) -> Int {
        let days1 = calendar.component(component, from: self)
        let days2 = calendar.component(component, from: date)
        return days1 - days2
    }
    
    func calculateTimeDifference(to endDate: Date) -> String {
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year,.month, .day, .hour, .minute], from: endDate, to: self)
        
        let year = components.year ?? 0
        let month = components.month ?? 0
        let days = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
       
        if year > 0 {
            return "\(year) year \(month)month"
        }
        
        if month > 0 {
            return "\(month) month \(days)d"
        }
        
        if days > 10 && days < 32{
            return "\(days) days "
        }
        
        if days > 0 && hours > 0 {
            return("\(days)d \(hours)h")
        }
        
        if days == 0 && hours > 10 {
            return "\(hours) hours"
        }
        
        let remainingMinutes = minutes % 60
        
        if days == 0 && hours <= 10 && hours > 0 {
            return  "\(hours) h \(minutes)m"
        }
        
        if days == 0 && hours == 0 && remainingMinutes > 0 {
            return "\(minutes) min"
        }
        
        if days == 0 && hours == 0 && remainingMinutes == 0 {
            return "less than a min"
        }
        
        return "none..."
    }
    
    func hasDatePassed() -> Bool {
        let currentDate = Date()
        
        return currentDate.compare(self) == .orderedDescending ? true : false
    }
    
    
}
