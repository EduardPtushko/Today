//
//  ReminderView.swift
//  Today
//
//  Created by Eduard Ptushko on 06.02.2024.
//

import SwiftUI

struct ReminderView: View {
    let reminder: Reminder

    var body: some View {
        List {
            Text(reminder.title)
                .font(.headline)
            HStack {
                Image(systemName: "calendar.circle")
                    .font(.headline)
                    .foregroundStyle(Color(uiColor: .todayPrimaryTint))
                Text(reminder.dueDate.dayText)
                    .font(.subheadline)
            }
            HStack {
                Image(systemName: "clock")
                    .font(.headline)
                    .foregroundStyle(Color(uiColor: .todayPrimaryTint))
                Text(reminder.dueDate.formatted(date: .omitted, time: .shortened))
                    .font(.subheadline)
            }
            HStack {
                Image(systemName: "square.and.pencil")
                    .font(.headline)
                    .foregroundStyle(Color(uiColor: .todayPrimaryTint))
                Text(reminder.notes ?? "")
                    .font(.subheadline)
            }

        }
        .listStyle(.insetGrouped)
        .navigationTitle("Reminder")
        .toolbarBackground(.visible, for: .navigationBar)

    }
}

#Preview {
    ReminderView(reminder: Reminder.sampleData[0])
}
