//
//  ReminderViewModel.swift
//  Today
//
//  Created by Eduard Ptushko on 15.01.2024.
//

import Foundation

@Observable
final class ReminderViewModel {
    var reminders: [Reminder] = []
    var error: String? {
        didSet {
            if oldValue == nil {
                showAlert = true
            } else {
                showAlert = false
            }
        }
    }

    var showAlert = false
    var listStyle: ReminderListStyle = .today

    private var reminderStore: ReminderStore { ReminderStore.shared }

    var filteredReminders: [Reminder] {
        reminders.filter { listStyle.shouldInclude(date: $0.dueDate) }.sorted {
            $0.dueDate < $1.dueDate
        }
    }

    var progress: Double {
        let chunkSize = 1.0 / Double(filteredReminders.count)
        let progress = filteredReminders.reduce(0.0) {
            let chunk = $1.isComplete ? chunkSize : 0
            return $0 + chunk
        }
        return progress
    }

    func reminder(withId id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfReminder(withId: id)
        return reminders[index]
    }

    func updateReminder(_ reminder: Reminder) {
        let index = reminders.indexOfReminder(withId: reminder.id)
        reminders[index] = reminder
    }

    func completeReminder(withId id: Reminder.ID) {
        var reminder = reminder(withId: id)
        reminder.isComplete.toggle()
        updateReminder(reminder)
    }

    func addReminder(_ reminder: Reminder) {
        reminders.append(reminder)
    }

    func deleteReminder(ids: [Reminder.ID]) {
        ids.forEach { id in
            let index = reminders.indexOfReminder(withId: id)
            reminders.remove(at: index)
        }
    }

    func prepareReminderStore() {
        Task {
            do {
                try await reminderStore.requestAccess()
                reminders = try await reminderStore.readAll()
                NotificationCenter.default.addObserver(self, selector: #selector(eventStoreChanged(_:)), name: .EKEventStoreChanged, object: nil)
            } catch TodayError.accessDenied, TodayError.accessRestricted {
                #if DEBUG
                reminders = Reminder.sampleData
                #endif
            } catch {
                self.error = error.localizedDescription
            }
        }
    }

    func reminderStoreChanged() {
        Task {
            reminders = try await reminderStore.readAll()
        }
    }

    @objc func eventStoreChanged(_ notification: NSNotification) {
        reminderStoreChanged()
    }
}
