//
//  Formatter.swift
//  HorseStable
//
//  Created by Lukas Korinek on 16/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

class Formatter {
    
    let formatter: DateFormatter
    
    init() {
        self.formatter = DateFormatter()
    }
    
    func getYYYYMMDD(from date: Date) -> String {
        self.formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    func getYYYYMMDD(from string: String) -> Date {
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: string) {
            return date
        } else {
            return Date()
        }
    }
    
    func getPreferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
}
