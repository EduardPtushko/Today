//
//  Reminder+EKReminder.swift
//  Today
//
//  Created by Eduard Ptushko on 12.02.2024.
//

import EventKit
import Foundation

extension Reminder {
    init(with ekReminder: EKReminder) throws {
        guard let dueDate = ekReminder.alarms?.first?.absoluteDate else {
            throw TodayError.reminderHasNoDueDate
        }

        id = ekReminder.calendarItemIdentifier
        self.dueDate = dueDate
        title = ekReminder.title
        notes = ekReminder.notes ?? ""
        isComplete = ekReminder.isCompleted
    }
}
