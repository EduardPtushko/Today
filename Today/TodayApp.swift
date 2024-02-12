//
//  TodayApp.swift
//  Today
//
//  Created by Eduard Ptushko on 15.01.2024.
//

import SwiftUI

@main
struct TodayApp: App {
    @State private var store = ReminderViewModel()

    var body: some Scene {
        WindowGroup {
            ReminderListView(store: store)
        }
    }
}
