//
//  NewReminder.swift
//  Today
//
//  Created by Eduard Ptushko on 08.02.2024.
//

import SwiftUI

struct NewReminder: View {
    @State private var reminder = Reminder.emptyReminder
    @Bindable var store: ReminderViewModel
    @Environment(\.dismiss)
    var dismiss
    @State private var isShowing = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("", text: $reminder.title)
                } header: {
                    Text("Title")
                }

                Section {
                    DatePicker("", selection: $reminder.dueDate)
                        .datePickerStyle(.graphical)
                } header: {
                    Text("Date")
                }

                Section {
                    TextEditor(text: $reminder.notes)
                } header: {
                    Text("Notes")
                }
            }

            .navigationTitle("Add Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                toolbarContent
            }
        }
    }
}

extension NewReminder {
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
            }
        }

        ToolbarItem(placement: .topBarTrailing) {
            Button {
                store.addReminder(reminder)
                dismiss()
            } label: {
                Text("Done")
            }
        }
    }
}

#Preview("Add Reminder") {
    NewReminder(store: ReminderViewModel())
}
