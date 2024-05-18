//
//  WeekBeatApp.swift
//  WeekBeat
//
//  Created by Lars Helmer on 2024-05-18.
//

import SwiftUI

@main
struct WeekBeatApp: App {
    @AppStorage("showWeek") private var showWeek = true
    @AppStorage("showBeat") private var showBeat = true
    @AppStorage("short") private var short = false
    
    var body: some Scene {
        MenuBarExtra {
            Toggle(isOn: $showWeek) {
                Text("Week")
            }
            Toggle(isOn: $showBeat) {
                Text("Beat")
            }
            Toggle(isOn: $short) {
                Text("Short")
            }
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        } label: {
            Text(calcLabel())
        }
    }
    
    func calcLabel() -> String {
        let calendar = Calendar.current
        let weekOfYear = calendar.component(.weekOfYear, from: Date(timeIntervalSinceNow: 0))
        var label = ""
        if (showWeek) {
            label = short ? "W " : "Week "
            label += weekOfYear.formatted()
        }
        if (showBeat) {
            if (showWeek) {
                label += " "
            }
            label += short ? "B " : "Beat "
            let b = Double(weekOfYear) / 2.0
            label += b.rounded(.toNearestOrAwayFromZero).formatted(.number)
        }
        if (!showWeek && !showBeat) {
            let components = Calendar.current.dateComponents([.month, .day], from: .now)
            let month = components.month ?? 0
            let day = components.day ?? 0
            if (month == 1 && day == 4) {
                label = "🫚"
            } else {
                label = "❤️"
            }
        }
        return label
    }
}
