//
//  Settinga.swift
//  pagebook
//
//  Created by Максим Гоглов on 28.10.2025.
//
import SwiftUI
import Combine

class Settings: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode = false
    @AppStorage("isNotificationsEnabled") var isNotificationsEnabled = true
    @AppStorage("defaultView") var defaultView = "notes"
    @AppStorage("fontSize") var fontSize = 16.0
    @AppStorage("accentColor") var accentColor = "Синий"
    
    var accentColorValue: Color {
        switch accentColor {
        case "Синий": return .blue
        case "Зеленый": return .green
        case "Фиолетовый": return .purple
        case "Оранжевый": return .orange
        case "Красный": return .red
        default: return .blue
        }
    }
}
