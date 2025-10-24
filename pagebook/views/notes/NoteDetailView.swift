//
//  NoteDetailView.swift
//  pagebook
//
//  Created by Максим Гоглов on 21.07.2025.
//
import SwiftUI

struct NoteDetailView: View {
    let note: Note
    @State private var isEditing = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Group {
            if isEditing {
                NoteEditorView(
                    note: note,
                    mode: .edit,
                    onSave: { _ in
                        isEditing = false
                    },
                    onCancel: {
                        isEditing = false
                    }
                )
            } else {
                NotePreviewView(note: note)
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(isEditing ? "Готово" : "Редактировать") {
                    isEditing.toggle()
                }
            }
        }
        .navigationTitle(isEditing ? "Редактирование" : note.title)
    }
}
