//
//  ReminderListView.swift
//  Today
//
//  Created by Eduard Ptushko on 15.01.2024.
//

import SwiftUI

struct ReminderListView: View {
    @Bindable var store: ReminderViewModel
    @State private var selection = ""
    @State private var showingAddReminder = false

    var body: some View {
        @Bindable var store = store
        NavigationStack {
            List {
                ProgressHeaderView(progress: store.progress)
                    .padding()
                    .listRowBackground(LinearGradient(colors: store.listStyle.colors(), startPoint: .top, endPoint: .bottom))

                ForEach(store.filteredReminders) { reminder in
                    NavigationLink {
                        ReminderView(reminder: reminder, store: store)
                    } label: {
                        HStack {
                            Image(systemName: reminder.isComplete ? "circle.fill" : "circle")
                                .font(.title)
                                .foregroundStyle(Color(uiColor: .todayListCellDoneButtonTint))
                                .onTapGesture {
                                    withAnimation {
                                        store.completeReminder(withId: reminder.id)
                                    }
                                }

                            VStack(alignment: .leading) {
                                Text(reminder.title)
                                Text(reminder.dueDate.dayAndTimeText)
                                    .font(.caption)
                            }
                        }
                    }
                    .listRowBackground(Color(uiColor: .todayListCellBackground))
                }
                .onDelete(perform: { indexSet in
                    let ids = indexSet.map { store.filteredReminders[$0].id }
                    store.deleteReminder(ids: ids)
                })
            }
            .listStyle(.plain)
            .background(LinearGradient(colors: store.listStyle.colors(), startPoint: .top, endPoint: .bottom))
            .toolbarBackground(.visible, for: .navigationBar)
            .scrollContentBackground(.hidden)
            .sheet(isPresented: $showingAddReminder, content: {
                NewReminder(store: store)
            })
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("Reminder list styles", selection: $store.listStyle) {
                        ForEach(ReminderListStyle.allCases) { reminderStyle in
                            Text(reminderStyle.name)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(maxWidth: 240)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddReminder = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .alert(NSLocalizedString("Error", comment: "Error alert title"), isPresented: $store.showAlert) {
                let actionTitle = NSLocalizedString("OK", comment: "Alert OK button title")
                Button(actionTitle, role: .cancel) {
                    store.error = nil
                }
            } message: {
                Text(store.error ?? "")
            }
            .onAppear {
                store.prepareReminderStore()
            }
        }
    }
}

#Preview {
    ReminderListView(store: ReminderViewModel())
}
