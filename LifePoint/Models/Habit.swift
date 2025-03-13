//
//  Habit.swift
//  LifePoint
//
//  Created by HAKAN on 13.02.2025.
//

import Foundation

struct Habit {
    let title: String
    let description: String?
    let targetTime: Date
    let frequency: HabitFrequency
    let goal: Int
}



enum HabitFrequency: String, CaseIterable {
    case daily = "Daily"
    case weekly = "Weekly"
    case monthly = "Monthly"
}
