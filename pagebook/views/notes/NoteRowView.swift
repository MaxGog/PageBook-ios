//
//  NoteRowView.swift
//  pagebook
//
//  Created by Максим Гоглов on 21.07.2025.
//
import SwiftUI

struct NoteRowView: View {
    let note: Note
    
    private var previewText: String {
        let lines = note.content.split(separator: "\n")
        return lines.first.map(String.init) ?? "Нет содержимого"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(note.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    Text(previewText)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(note.createdAt, style: .date)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    
                    if note.updatedAt != note.createdAt {
                        Text("Изменено")
                            .font(.caption2)
                            .foregroundColor(.orange)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.orange.opacity(0.1))
                            .cornerRadius(4)
                    }
                }
            }
            
            if !note.content.isEmpty {
                HStack {
                    Text("\(note.content.count) слов")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    
                }
            }
        }
        .padding(.vertical, 8)
        .accessibilityElement(children: .combine)
        .accessibilityHint("Двойное нажатие для открытия")
    }
}
