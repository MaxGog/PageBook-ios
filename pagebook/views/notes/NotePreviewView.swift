//
//  NotePreviewView.swift
//  pagebook
//
//  Created by Максим Гоглов on 21.07.2025.
//
import SwiftUI

struct NotePreviewView: View {
    let note: Note
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(note.title)
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Text("Создано: \(note.createdAt, style: .date)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        if note.updatedAt != note.createdAt {
                            Text("•")
                                .foregroundColor(.secondary)
                            Text("Изменено: \(note.updatedAt, style: .date)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Divider()
                
                if note.content.isEmpty {
                    EmptyContentView()
                } else {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(note.content)
                            .font(.body)
                            .lineSpacing(4)
                            .textSelection(.enabled)
                        
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
