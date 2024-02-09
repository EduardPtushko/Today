//
//  ReminderViewModel.swift
//  Today
//
//  Created by Eduard Ptushko on 15.01.2024.
//

import Foundation

@Observable
final class ReminderStore {
    var reminders: [Reminder] = []
    var listStyle: ReminderListStyle = .today
    
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

    init() {
        reminders = Reminder.sampleData
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

}
