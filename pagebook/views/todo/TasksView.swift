//
//  TasksView.swift
//  pagebook
//
//  Created by Максим Гоглов on 13.07.2025.
//
import SwiftUI

struct TasksView: View {
    @StateObject private var store = TaskStore()
    @State private var isShowingAddTask = false
    @State private var newTaskTitle = ""
    @State private var newTaskDueDate = Date()
    @State private var newTaskPriority: TaskItem.Priority = .medium
    @State private var isShowingCompleted = true
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(filteredTasks) { task in
                        TaskRow(task: task, toggleCompletion: toggleTaskCompletion)
                    }
                    .onDelete(perform: deleteTasks)
                }
            }
            .navigationTitle("Задачи")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingAddTask = true
                    } label: {
                        Label("Добавить задачу", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .secondaryAction) {
                    Toggle(isOn: $isShowingCompleted) {
                        Label("Показать выполненные", systemImage: "eye")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddTask) {
                AddTaskView(
                    isPresented: $isShowingAddTask,
                    title: $newTaskTitle,
                    dueDate: $newTaskDueDate,
                    priority: $newTaskPriority,
                    onAdd: addNewTask
                )
            }
        }
    }
    
    private var filteredTasks: [TaskItem] {
        store.tasks.filter { isShowingCompleted || !$0.isCompleted }
                   .sorted { $0.priority.rawValue > $1.priority.rawValue }
    }
    
    private func toggleTaskCompletion(_ task: TaskItem) {
        if let index = store.tasks.firstIndex(where: { $0.id == task.id }) {
            store.tasks[index].isCompleted.toggle()
            store.saveTasks()
        }
    }
    
    private func addNewTask() {
        let task = TaskItem(
            id: UUID(),
            title: newTaskTitle,
            isCompleted: false,
            dueDate: newTaskDueDate,
            priority: newTaskPriority
        )
        store.tasks.append(task)
        store.saveTasks()
        isShowingAddTask = false
        resetForm()
    }
    
    private func deleteTasks(at offsets: IndexSet) {
        store.tasks.remove(atOffsets: offsets)
        store.saveTasks()
    }
    
    private func resetForm() {
        newTaskTitle = ""
        newTaskDueDate = Date()
        newTaskPriority = .medium
    }
}
