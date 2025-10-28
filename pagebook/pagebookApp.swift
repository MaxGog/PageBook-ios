//
//  pagebookApp.swift
//  pagebook
//
//  Created by Максим Гоглов on 13.07.2025.
//

import SwiftUI
import SwiftData

@main
struct pagebookApp: App {
    @StateObject private var settings = Settings()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(settings)
                .preferredColorScheme(settings.isDarkMode ? .dark : .none)
                .accentColor(settings.accentColorValue)
        }
    }
}
