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


}
