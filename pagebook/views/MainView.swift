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
        case settings
    }
    
    @State private var selectedTab: Tab = .notes
    @EnvironmentObject var settings: Settings
    
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
            
            SettingsView()
                .tabItem {
                    Label("Настройки", systemImage: "gear")
                }
                .tag(Tab.settings)
        }
        .accentColor(settings.accentColorValue)
        .onAppear {
            applyTheme()
        }
        .onChange(of: settings.isDarkMode) { _ in
            applyTheme()
        }
    }
}

private func applyTheme() {
    #if os(iOS)
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        windowScene.windows.first?.overrideUserInterfaceStyle = settings.isDarkMode ? .dark : .light
    }
    #endif
}
