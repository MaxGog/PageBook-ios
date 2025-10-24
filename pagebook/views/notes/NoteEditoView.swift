//
//  NoteEditView.swift
//  pagebook
//
//  Created by Максим Гоглов on 21.07.2025.
//
import SwiftUI

struct NoteEditorView: View {
    let note: Note?
    let mode: EditorMode
    let onSave: (Note) -> Void
    let onCancel: () -> Void
    
    @State private var editedTitle: String
    @State private var editedContent: String
    @FocusState private var focusedField: Field?
    
    enum EditorMode {
        case create, edit
    }
    
    private enum Field {
        case title, content
    }
    
    init(note: Note? = nil, mode: EditorMode, onSave: @escaping (Note) -> Void, onCancel: @escaping () -> Void) {
        self.note = note
        self.mode = mode
        self.onSave = onSave
        self.onCancel = onCancel
        self._editedTitle = State(initialValue: note?.title ?? "")
        self._editedContent = State(initialValue: note?.content ?? "")
    }
    
    private var isSaveDisabled: Bool {
        editedTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private var currentNote: Note {
        if let existingNote = note {
            return Note(
                id: existingNote.id,
                title: editedTitle.trimmingCharacters(in: .whitespacesAndNewlines),
                content: editedContent,
                createdAt: existingNote.createdAt,
                updatedAt: Date()
            )
        } else {
            return Note(
                id: UUID(),
                title: editedTitle.trimmingCharacters(in: .whitespacesAndNewlines),
                content: editedContent,
                createdAt: Date(),
                updatedAt: Date()
            )
        }
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Название заметки", text: $editedTitle)
                    .focused($focusedField, equals: .title)
                    .submitLabel(.next)
                    .font(.headline)
                    .onSubmit {
                        focusedField = .content
                    }
            } header: {
                Text("Заголовок")
            }
            
            Section {
                TextEditor(text: $editedContent)
                    .focused($focusedField, equals: .content)
                    .frame(minHeight: 200)
                    .overlay(
                        editedContent.isEmpty ?
                        Text("Начните писать здесь...")
                            .foregroundColor(.secondary)
                            .padding(.top, 8)
                            .padding(.leading, 5)
                            .allowsHitTesting(false)
                        : nil,
                        alignment: .topLeading
                    )
            } header: {
                HStack {
                    Text("Содержимое")
                }
            }
            
            if mode == .edit, let note = note {
                Section {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Создано: \(note.createdAt, style: .date) в \(note.createdAt, style: .time)")
                        if note.updatedAt != note.createdAt {
                            Text("Изменено: \(note.updatedAt, style: .date) в \(note.updatedAt, style: .time)")
                        }
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                } header: {
                    Text("Информация")
                }
            }
        }
        .navigationTitle(mode == .create ? "Новая заметка" : "Редактирование")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Отмена", role: .cancel, action: onCancel)
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Сохранить") {
                    onSave(currentNote)
                }
                .disabled(isSaveDisabled)
                .fontWeight(.semibold)
            }
            
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Готово") {
                    focusedField = nil
                }
            }
        }
        .onAppear {
            if mode == .create {
                focusedField = .title
            }
        }
    }
}
