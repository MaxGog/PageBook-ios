//
//  NotificationSettingsView.swift
//  pagebook
//
//  Created by Максим Гоглов on 28.10.2025.
//
import SwiftUI

struct NotificationSettingsView: View {
    @AppStorage("notificationsSound") private var soundEnabled = true
    @AppStorage("notificationsVibration") private var vibrationEnabled = true
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        List {
            Section {
                Toggle("Звук", isOn: $soundEnabled)
                Toggle("Вибрация", isOn: $vibrationEnabled)
            } header: {
                Text("Типы уведомлений")
            } footer: {
                Text("Настройте способ получения уведомлений")
            }
            
            Section {
                DatePicker("Утреннее напоминание",
                          selection: .constant(Date().addingTimeInterval(3600 * 9)),
                          displayedComponents: .hourAndMinute)
                DatePicker("Вечернее напоминание",
                          selection: .constant(Date().addingTimeInterval(3600 * 19)),
                          displayedComponents: .hourAndMinute)
            } header: {
                Text("Время напоминаний")
            } footer: {
                Text("Установите удобное время для ежедневных напоминаний")
            }
        }
        .navigationTitle("Уведомления")
        .font(.system(size: settings.fontSize))
    }
}
