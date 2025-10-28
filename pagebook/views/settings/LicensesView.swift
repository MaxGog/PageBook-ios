//
//  LicensesView.swift
//  pagebook
//
//  Created by Максим Гоглов on 28.10.2025.
//


import SwiftUI

struct LicensesView: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Лицензии")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("Это приложение создано с использованием следующих технологий:")
                        .foregroundColor(.secondary)
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    LicenseRow(title: "SwiftUI", description: "Фреймворк от Apple для создания пользовательских интерфейсов")
                    LicenseRow(title: "SwiftData", description: "Фреймворк для хранения и управления данными")
                    LicenseRow(title: "UserNotifications", description: "Фреймворк для работы с уведомлениями")
                }
                
                Text("Все права защищены. © 2025")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 20)
            }
            .padding()
        }
        .navigationTitle("Лицензии")
        .font(.system(size: settings.fontSize))
    }
}

struct LicenseRow: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

