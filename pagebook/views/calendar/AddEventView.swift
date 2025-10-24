//
//  AddEventView.swift
//  pagebook
//
//  Created by Максим Гоглов on 21.07.2025.
//
import SwiftUI

struct AddEventView: View {
    @Binding var isPresented: Bool
    @Binding var title: String
    @Binding var description: String
    @Binding var date: Date
    @Binding var duration: Double
    let onAdd: () -> Void
    
    @FocusState private var focusedField: Field?
    
    private enum Field {
        case title, description
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Название события", text: $title)
                        .focused($focusedField, equals: .title)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .description
                        }
                } header: {
                    Text("Основная информация")
                }
                
                Section {
                    DatePicker("Дата и время",
                             selection: $date,
                             in: Date()...)
                        .datePickerStyle(.compact)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Продолжительность: \(duration.formatted()) ч")
                            .font(.headline)
                        
                        HStack {
                            Image(systemName: "hourglass")
                                .foregroundColor(.secondary)
                            
                            Slider(value: $duration, in: 0.5...8, step: 0.5)
                            
                            Image(systemName: "hourglass.tophalf.filled")
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            ForEach([0.5, 1.0, 2.0, 4.0], id: \.self) { hours in
                                Button("\(hours.formatted())ч") {
                                    withAnimation(.spring()) {
                                        duration = hours
                                    }
                                }
                                .font(.caption)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(duration == hours ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(duration == hours ? .white : .primary)
                                .cornerRadius(6)
                            }
                        }
                    }
                    .padding(.vertical, 8)
                } header: {
                    Text("Время")
                }
                
                Section {
                    TextField("Описание (необязательно)", text: $description, axis: .vertical)
                        .focused($focusedField, equals: .description)
                        .lineLimit(3...6)
                } header: {
                    Text("Детали")
                }
            }
            .navigationTitle("Новое событие")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена", role: .cancel) {
                        isPresented = false
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Добавить", action: onAdd)
                        .disabled(title.isEmpty)
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
                focusedField = .title
            }
        }
        .interactiveDismissDisabled(!title.isEmpty)
    }
}
