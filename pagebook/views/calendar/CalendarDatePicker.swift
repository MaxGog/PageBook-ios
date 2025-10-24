//
//  CalendarDatePicker.swift
//  pagebook
//
//  Created by Максим Гоглов on 21.07.2025.
//
import SwiftUI

struct CalendarDatePicker: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(selectedDate, style: .date)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            DatePicker(
                "Выберите дату",
                selection: $selectedDate,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .tint(.blue)
        }
        .padding(.vertical, 12)
    }
}
