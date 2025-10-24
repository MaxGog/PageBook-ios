//
//  TaskRow.swift
//  pagebook
//
//  Created by Максим Гоглов on 21.07.2025.
//


import SwiftUI

struct TaskRow: View {
    let task: TaskItem
    let toggleCompletion: (TaskItem) -> Void
    
    var body: some View {
        HStack {
            Button {
                toggleCompletion(task)
            } label: {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.priority.color)
                    .contentTransition(.symbolEffect)
            }
            .buttonStyle(.plain)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .strikethrough(task.isCompleted)
                    .foregroundColor(task.isCompleted ? .secondary : .primary)
                
                if let dueDate = task.dueDate {
                    Text(dueDate, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Text(task.priority.description)
                .font(.caption)
                .foregroundColor(task.priority.color)
        }
        .accessibilityElement(children: .combine)
        .accessibilityHint("Двойное нажатие для отметки выполнения")
    }
}
