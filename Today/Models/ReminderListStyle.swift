//
//  ReminderListStyle.swift
//  Today
//
//  Created by Eduard Ptushko on 08.02.2024.
//

import SwiftUI

enum ReminderListStyle: Int, CaseIterable, Identifiable {
    case today
    case future
    case all

    var id: Self {
        self
    }

    var name: String {
        switch self {
        case .today:
            return NSLocalizedString("Today", comment: "Today style name")
        case .future:
            return NSLocalizedString("Future", comment: "Future style name")
        case .all:
            return NSLocalizedString("All", comment: "All style name")
        }
    }

    func shouldInclude(date: Date) -> Bool {
        let isInToday = Locale.current.calendar.isDateInToday(date)
        
        switch self {
        case .today:
            return isInToday
        case .future:
            return (date > Date.now) && !isInToday
        case .all:
            return true
        }
    }

    func colors() -> [Color] {
        let beginColor: Color
        let endColor: Color

        switch self {
        case .all:
            beginColor = Color(uiColor: .todayGradientAllBegin)
            endColor = Color(uiColor: .todayGradientAllEnd)
        case .future:
            beginColor = Color(uiColor: .todayGradientFutureBegin)
             endColor = Color(uiColor: .todayGradientFutureEnd)
        case .today:
           beginColor = Color(uiColor: .todayGradientTodayBegin)
           endColor = Color(uiColor: .todayGradientTodayEnd)
        }

        return [beginColor, endColor]
    }
}
