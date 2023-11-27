//
//  ScreenPages.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//

import SwiftUI

enum Page{
    case eventsList
    case content
}

enum Sheets: Hashable, Equatable, Identifiable {
    
    case createEvent
    case shared
    case editIvent(IventModel)
    case shareUseActivityVC(IventModel)
    case shareByQRCode(IventModel)
    case createEventFromQR(String)
    
    var id: Self {
        self
    }
}
