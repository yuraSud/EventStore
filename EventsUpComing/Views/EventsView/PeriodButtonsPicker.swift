//
//  PeriodButtonsPicker.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 14.11.2023.
//
import Observation
import SwiftUI

struct PeriodButtonsPicker: View {

    @Binding var selectedIndexButton: Period
    @Binding var isDatePickerPresent: Bool
   
    var body: some View {
        
        HStack(spacing: 10) {
            ForEach(Period.allCases) { item in
                ButtonChoise(title: item.title, isTaped: selectedIndexButton == item)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedIndexButton = item
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
    PeriodButtonsPicker(selectedIndexButton: .constant(.month), isDatePickerPresent: .constant(true))
}
