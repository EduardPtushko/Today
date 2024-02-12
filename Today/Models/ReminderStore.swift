//
//  ReminderStore.swift
//  Today
//
//  Created by Eduard Ptushko on 12.02.2024.
//

import EventKit
import Foundation

final class ReminderStore {
    static let shared = ReminderStore()

    private let ekStore = EKEventStore()

    var isAvailable: Bool {
        EKEventStore.authorizationStatus(for: .reminder) == .authorized
    }
}
