//
//  CalendarView.swift
//  pagebook
//
//  Created by Максим Гоглов on 13.07.2025.
//
import SwiftUI

struct CalendarView: View {
    @StateObject private var store = CalendarStore()
    @State private var selectedDate = Date()
    @State private var isShowingAddEvent = false
    @State private var newEventTitle = ""
    @State private var newEventDescription = ""
    @State private var newEventDate = Date()
    @State private var newEventDuration = 1.0
    
    private var eventsForSelectedDate: [CalendarEvent] {
        store.events.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
                   .sorted { $0.date < $1.date }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                CalendarDatePicker(selectedDate: $selectedDate)
                    .padding(.horizontal)
                
                Divider()
                
                if eventsForSelectedDate.isEmpty {
                    EmptyStateView(selectedDate: selectedDate)
                } else {
                    EventListView(
                        events: eventsForSelectedDate,
                        onDelete: deleteEvents
                    )
                }
            }
            .navigationTitle("Календарь")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        newEventDate = selectedDate
                        isShowingAddEvent = true
                    } label: {
                        Label("Добавить событие", systemImage: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddEvent) {
                AddEventView(
                    isPresented: $isShowingAddEvent,
                    title: $newEventTitle,
                    description: $newEventDescription,
                    date: $newEventDate,
                    duration: $newEventDuration,
                    onAdd: addNewEvent
                )
            }
        }
    }
    
    private func addNewEvent() {
        let event = CalendarEvent(
            id: UUID(),
            title: newEventTitle,
            description: newEventDescription,
            date: newEventDate,
            duration: newEventDuration
        )
        store.events.append(event)
        store.saveEvents()
        isShowingAddEvent = false
        resetForm()
    }
    
    private func deleteEvents(at offsets: IndexSet) {
        store.events.remove(atOffsets: offsets)
        store.saveEvents()
    }
    
    private func resetForm() {
        newEventTitle = ""
        newEventDescription = ""
        newEventDate = Date()
        newEventDuration = 1.0
    }
}
