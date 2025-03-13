//
//  NotificatonCenter.swift
//  LifePoint
//
//  Created by HAKAN on 13.03.2025.
//

import Foundation
import UIKit
import UserNotifications


class
LPNotification {
    
    func scheduleNotification(for habit: Habit) {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if !granted {
                print("Notification permission denied")
                return
            }
            
            if let error = error {
                print("Error requesting notification permissions: \(error)")
                return
            }
            
            
            let content = UNMutableNotificationContent()
            content.title = "Habit Time!"
            content.body = "It's time to \(habit.title)!"
            content.sound = .default
            
            
            let calendar = Calendar.current
            var dateComponents = calendar.dateComponents([.hour, .minute], from: habit.targetTime)
            
            
            let trigger: UNCalendarNotificationTrigger
            
            switch habit.frequency {
            case .daily:
                trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            case .weekly:
                dateComponents.weekday = calendar.component(.weekday, from: habit.targetTime)
                trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            case .monthly:
                dateComponents.day = calendar.component(.day, from: habit.targetTime)
                trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            }
            
            
            let identifier = "HabitReminder_\(habit.title)"
            
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            
            center.add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                } else {
                    print("Notification scheduled for \(habit.title) at \(habit.targetTime)")
                }
            }
        }
    }
    
    
    func cancelNotification(for habit: Habit) {
        let center = UNUserNotificationCenter.current()
        let identifier = "HabitReminder_\(habit.title)"
           
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
        print("Notification canceled for \(habit.title)")
    }
    
}
