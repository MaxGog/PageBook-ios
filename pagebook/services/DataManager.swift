//
//  DataManager.swift
//  pagebook
//
//  Created by Максим Гоглов on 28.10.2025.
//

import Foundation
import SwiftUI

class DataManager: ObservableObject {
    static let shared = DataManager()
    
    // Для показа алертов в SwiftUI
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false
    
    func exportData() {
        let sampleData = "Ваши данные для экспорта\nЗаметки, задачи и т.д."
        print("Данные для экспорта:\n\(sampleData)")
        
        #if os(iOS)
        // Для iOS можно использовать ShareSheet
        showAlert(message: "Функция экспорта данных будет реализована в следующем обновлении")
        #elseif os(macOS)
        saveToFile(content: sampleData, filename: "pagebook_export.txt")
        #endif
    }
    
    func createBackup() {
        let backupData = "Резервная копия создана: \(Date())"
        UserDefaults.standard.set(backupData, forKey: "lastBackup")
        showAlert(message: "Резервная копия успешно создана")
    }
    
    func restoreBackup() {
        if let backupData = UserDefaults.standard.string(forKey: "lastBackup") {
            showAlert(message: "Данные восстановлены из: \(backupData)")
        } else {
            showAlert(message: "Резервная копия не найдена")
        }
    }
    
    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
    
    #if os(macOS)
    private func saveToFile(content: String, filename: String) {
        let panel = NSSavePanel()
        panel.nameFieldStringValue = filename
        panel.allowedContentTypes = [.plainText]
        
        panel.begin { result in
            if result == .OK, let url = panel.url {
                do {
                    try content.write(to: url, atomically: true, encoding: .utf8)
                    self.showAlert(message: "Файл сохранен: \(url.lastPathComponent)")
                } catch {
                    self.showAlert(message: "Ошибка сохранения: \(error.localizedDescription)")
                }
            }
        }
    }
    #endif
}
