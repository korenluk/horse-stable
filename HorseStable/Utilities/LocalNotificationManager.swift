//
//  LocalNotificationManager.swift
//  HorseStable
//
//  Created by Lukas Korinek on 26/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation
import UserNotifications

struct Notification {
    var id: String
    var title: String
    var date: Date
}

class LocalNotificationManager {
    var notifications = [Notification]()
    
    func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
                if granted == true && error == nil {
                    self.scheduleNotifications()
                    // We have permission!
                }
        }
    }
    
    func addNotification(title: String, date: Date) -> Void {
        notifications.append(Notification(id: UUID().uuidString, title: title, date: date))
    }
    
    func schedule() -> Void {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestPermission()
            case .authorized, .provisional:
                self.scheduleNotifications()
            default:
                break
            }
        }
    }
    
    func scheduleNotifications() -> Void {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.badge = 1
            
            let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: notification.date)
//            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
            
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
                print("Scheduling notification with id: \(notification.id)")
            }
        }
    }
}
