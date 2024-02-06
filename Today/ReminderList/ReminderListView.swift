//
//  ReminderListView.swift
//  Today
//
//  Created by Eduard Ptushko on 15.01.2024.
//

import SwiftUI

struct ReminderListView: View {
    var viewModel = ReminderViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.reminders) { reminder in
                    NavigationLink {
                        ReminderView(reminder: reminder)
                    } label: {
                        HStack {
                            Image(systemName: reminder.isComplete ? "circle.fill" : "circle")
                                .font(.title)
                                .foregroundStyle(Color(uiColor: .todayListCellDoneButtonTint))
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.completeReminder(withId: reminder.id)
                                    }
                                }

                            VStack(alignment: .leading) {
                                Text(reminder.title)
                                Text(reminder.dueDate.dayAndTimeText)
                                    .font(.caption)
                            }
                        }
                        .background(Color(uiColor: .todayListCellBackground))
                    }
                }
            }
            .listStyle(.inset)
            .toolbar(.visible)
        }
    }
}

#Preview {
    ReminderListView()
}
