//
//  TodayError.swift
//  Today
//
//  Created by Eduard Ptushko on 12.02.2024.
//

import Foundation

enum TodayError: LocalizedError {
    case failedReadingReminders

    var errorDescription: String? {
        switch self {
        case .failedReadingReminders:
            return NSLocalizedString("Failed to read reminders.", comment: "failed reading reminders error description")
        }
    }
}
