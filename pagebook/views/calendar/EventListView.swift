//
//  EventListView.swift
//  pagebook
//
//  Created by Максим Гоглов on 21.07.2025.
//
import SwiftUI

struct EventListView: View {
    let events: [CalendarEvent]
    let onDelete: (IndexSet) -> Void
    
    var body: some View {
        List {
            ForEach(events) { event in
                EventRow(event: event)
                    .listRowSeparator(.visible)
                    .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            }
            .onDelete(perform: onDelete)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

struct EventRow: View {
    let event: CalendarEvent
    
    private var endDate: Date {
        event.date.addingTimeInterval(event.duration * 3600)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    if !event.description.isEmpty {
                        Text(event.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(eventDateFormatter.string(from: event.date))
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    
                    Text("\(Int(event.duration)) ч")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(4)
                }
            }
            
            HStack {
                Image(systemName: "clock")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                
                Text("\(event.timeString) - \(endDate.timeIntervalSinceNow)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                if event.isHappeningNow {
                    Text("Сейчас")
                        .font(.caption2)
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.green)
                        .cornerRadius(4)
                }
            }
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
        .accessibilityHint("Свайпните влево для удаления")
    }
}

private let eventDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    return formatter
}()

extension CalendarEvent {
    var timeString: String {
        eventDateFormatter.string(from: date)
    }
    
    var isHappeningNow: Bool {
        let now = Date()
        let end = date.addingTimeInterval(duration * 3600)
        return now >= date && now <= end
    }
}
