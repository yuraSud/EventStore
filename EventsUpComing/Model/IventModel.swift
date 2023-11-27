//
//  CellModel.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 14.11.2023.
//

import SwiftUI
import SwiftData


@Model
final class IventModel: Identifiable, Hashable, Equatable, Codable {
    var title: String
    var notes: String
    var date: Date
    var id = UUID().uuidString

    init(title: String, notes: String = "", date: Date = .now) {
        self.title = title
        self.notes = notes
        self.date = date
    }
    
    static func currentPredicate(to date: Date) -> Predicate<IventModel> {
        let currentDate = Date.now
        
        return #Predicate<IventModel> { event in
            event.date > currentDate && event.date <= date
        }
    }
    
    // MARK: - Codable

       enum CodingKeys: String, CodingKey {
           case title, notes, date, id
       }

       required init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)

           title = try container.decode(String.self, forKey: .title)
           notes = try container.decode(String.self, forKey: .notes)
           date = try container.decode(Date.self, forKey: .date)
           id = try container.decode(String.self, forKey: .id)
       }

       func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)

           try container.encode(title, forKey: .title)
           try container.encode(notes, forKey: .notes)
           try container.encode(date, forKey: .date)
           try container.encode(id, forKey: .id)
       }

}
