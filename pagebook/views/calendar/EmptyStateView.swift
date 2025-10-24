//
//  EmptyStateView.swift
//  pagebook
//
//  Created by Максим Гоглов on 24.10.2025.
//


import SwiftUI

struct EmptyStateView: View {
    let selectedDate: Date
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "calendar.badge.plus")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
                .symbolRenderingMode(.hierarchical)
            
            VStack(spacing: 8) {
                Text("Событий нет")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Добавьте первое событие на \(selectedDate, style: .date)")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Нет событий на выбранную дату")
    }
}
