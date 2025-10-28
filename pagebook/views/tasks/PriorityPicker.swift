//
//  PriorityPicker.swift
//  pagebook
//
//  Created by Максим Гоглов on 21.07.2025.
//

import SwiftUI

struct PriorityPicker: View {
    @Binding var selection: TaskItem.Priority
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(TaskItem.Priority.allCases, id: \.self) { priority in
                PriorityOption(priority: priority, isSelected: priority == selection)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selection = priority
                        }
                    }
                    .accessibilityAddTraits(priority == selection ? .isSelected : [])
            }
        }
        .padding(.vertical, 8)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Приоритет задачи")
    }
}

struct PriorityOption: View {
    let priority: TaskItem.Priority
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: priority.iconName)
                .font(.title3)
                .foregroundColor(isSelected ? .white : priority.color)
                .padding(10)
                .background(
                    Circle()
                        .fill(isSelected ? priority.color : Color.clear)
                        .overlay(
                            Circle()
                                .stroke(priority.color, lineWidth: isSelected ? 0 : 1)
                        )
                )
            
            Text(priority.description)
                .font(.caption)
                .foregroundColor(isSelected ? priority.color : .primary)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
    }
}
