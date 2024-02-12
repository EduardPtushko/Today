//
//  EditReminder.swift
//  Today
//
//  Created by Eduard Ptushko on 09.02.2024.
//

import SwiftUI

struct EditReminder: View {
    let reminder: Reminder
    @Bindable var store: ReminderViewModel
    @Binding var showEdit: Bool
    @State private var editedReminder = Reminder.emptyReminder

    @State private var isShowing = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("", text: $editedReminder.title)
                } header: {
                    Text("Title")
                }

                Section {
                    DatePicker("", selection: $editedReminder.dueDate)
                        .datePickerStyle(.graphical)
                } header: {
                    Text("Date")
                }

                Section {
                    TextEditor(text: $editedReminder.notes)
                } header: {
                    Text("Notes")
                }
            }
            .navigationTitle("Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                toolbarContent
            }
        }
        .onAppear {
            editedReminder = reminder
        }
    }
}

extension EditReminder {
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button {
                withAnimation {
                    showEdit = false
                }
            } label: {
                Text("Cancel")
            }
        }

        ToolbarItem(placement: .topBarTrailing) {
            Button {
                store.updateReminder(editedReminder)
                withAnimation {
                    showEdit = false
                }
            } label: {
                Text("Done")
            }
        }
    }
}

#Preview {
    EditReminder(reminder: Reminder.sampleData[0], store: ReminderViewModel(), showEdit: .constant(true))
}
