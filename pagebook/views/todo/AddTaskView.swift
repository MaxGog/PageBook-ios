//
//  AddTaskView.swift
//  pagebook
//
//  Created by Максим Гоглов on 21.07.2025.
//

import SwiftUI

struct AddTaskView: View {
    @Binding var isPresented: Bool
    @Binding var title: String
    @Binding var dueDate: Date
    @Binding var priority: TaskItem.Priority
    let onAdd: () -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Название задачи", text: $title)
                        .font(.headline)
                        .submitLabel(.done)
                        .onSubmit {
                            if !title.isEmpty {
                                onAdd()
                            }
                        }
                } header: {
                    Text("Основная информация")
                }
                
                Section {
                    PriorityPicker(selection: $priority)
                        .padding(.vertical, 8)
                } header: {
                    Text("Приоритет")
                }
                
                Section {
                    DatePicker("Срок выполнения",
                             selection: $dueDate,
                             in: Date()...,
                             displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .padding(.vertical, 4)
                } header: {
                    Text("Срок выполнения")
                }
            }
            .navigationTitle("Новая задача")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена", role: .cancel) {
                        isPresented = false
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Добавить", action: onAdd)
                        .disabled(title.isEmpty)
                        .fontWeight(.semibold)
                }
            }
        }
        .interactiveDismissDisabled(!title.isEmpty)
    }
}
