//
//  MainView.swift
//  pagebook
//
//  Created by Максим Гоглов on 13.07.2025.
//
import SwiftUI

struct MainView: View {
    private enum Tab: Hashable {
        case notes
        case tasks
        case calendar
    }
    
    @State private var selectedTab: Tab = .notes
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NotesView()
                .tabItem {
                    Label("Заметки", systemImage: "note.text")
                }
                .tag(Tab.notes)
            
            TasksView()
                .tabItem {
                    Label("Задачи", systemImage: "checklist")
                }
                .tag(Tab.tasks)
            
            CalendarView()
                .tabItem {
                    Label("Календарь", systemImage: "calendar")
                }
                .tag(Tab.calendar)
        }
    }
}
