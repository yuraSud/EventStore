//
//  Font+Extension.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//

import SwiftUI

extension Font {
    
    enum Inter: CaseIterable {
        
        case regular
        case semibold
        
        var value: String {
            switch self {
            case .regular:
                "Poppins-Regular.ttf"
            case .semibold:
                "Poppins-SemiBold.ttf"
            }
        }
        
        static func inter(_ type: Inter, size: CGFloat) -> Font {
            return .custom(type.value, size: size)
        }
    }
}
