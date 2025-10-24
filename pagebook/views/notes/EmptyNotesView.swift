//
//  EmptyNotesView.swift
//  pagebook
//
//  Created by Максим Гоглов on 24.10.2025.
//
import SwiftUI

struct EmptyNotesView: View {
    let searchText: String
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "note.text")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
                .symbolRenderingMode(.hierarchical)
            
            VStack(spacing: 8) {
                if searchText.isEmpty {
                    Text("Заметок пока нет")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("Создайте первую заметку, чтобы начать")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                } else {
                    Text("Ничего не найдено")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("Попробуйте изменить запрос")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .accessibilityElement(children: .combine)
    }
}

struct EmptyContentView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "text.bubble")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text("Заметка пуста")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
    }
}
