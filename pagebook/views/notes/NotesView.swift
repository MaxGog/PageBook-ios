//
//  ContentView.swift
//  pagebook
//
//  Created by Максим Гоглов on 13.07.2025.
//

import SwiftUI

struct NotesView: View {
    @StateObject private var store = NotesStore()
    @State private var isShowingNewNote = false
    @State private var searchText = ""
    
    private var filteredNotes: [Note] {
        if searchText.isEmpty {
            return store.notes
        } else {
            return store.notes.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if filteredNotes.isEmpty {
                    EmptyNotesView(searchText: searchText)
                } else {
                    NotesListView(
                        notes: filteredNotes,
                        onDelete: deleteNotes
                    )
                }
            }
            .navigationTitle("Заметки")
            .searchable(text: $searchText, prompt: "Поиск заметок...")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingNewNote = true
                    } label: {
                        Label("Новая заметка", systemImage: "square.and.pencil")
                    }
                }
            }
            .sheet(isPresented: $isShowingNewNote) {
                NavigationStack {
                    NoteEditorView(
                        mode: .create,
                        onSave: { newNote in
                            store.notes.append(newNote)
                            store.saveNotes()
                            isShowingNewNote = false
                        },
                        onCancel: {
                            isShowingNewNote = false
                        }
                    )
                }
            }
        }
    }
    
    private func deleteNotes(at offsets: IndexSet) {
        store.notes.remove(atOffsets: offsets)
        store.saveNotes()
    }
}
