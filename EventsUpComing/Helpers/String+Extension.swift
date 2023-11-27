//
//  String+Extension.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 27.11.2023.
//

import Foundation

extension String {
    func extractDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d,MMM yyyy, hh:mm"
        
        if let parsedDate = dateFormatter.date(from: self) {
            return parsedDate
        } else {
            return .now
        }
    }
}
