//
//  PeriodButtonsPicker.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 14.11.2023.
//

import SwiftUI

struct PeriodButtonsPicker: View {
   
    @Binding var selectedIndex: Period
    @Binding var isDatePickerPresent: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(Period.allCases) { item in
                ButtonChoise(title: item.title, isTaped: selectedIndex == item)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedIndex = item
                            if item == .custom {
                                isDatePickerPresent.toggle()
                            }
                        }
                        
                    }
            }
        }
    }
}

#Preview {
    PeriodButtonsPicker(selectedIndex: .constant(.month), isDatePickerPresent: .constant(true))
}
