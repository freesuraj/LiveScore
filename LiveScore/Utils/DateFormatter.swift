//
//  DateFormatter.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import Foundation

class DateFormatterUtil {
    static let hourMinute: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale.current
        return formatter
    }()
    
    static let fullDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "eeee dd MMM yyyy"
        formatter.locale = Locale.current
        return formatter
    }()
}

extension Date {
    func formatAsHourMinute() -> String {
        DateFormatterUtil.hourMinute.string(from: self)
    }
    
    func formatAsFullDate() -> String {
        DateFormatterUtil.fullDate.string(from: self)
    }
}
