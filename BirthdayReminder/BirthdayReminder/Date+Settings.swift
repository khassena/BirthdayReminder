//
//  Date+Settings.swift
//  UIPickerView
//
//  Created by Amanzhan Zharkynuly on 24.10.2022.
//

import UIKit

var calendarCurrent = currentDate()

func currentDate() -> Calendar {
    var calendar = Calendar.current
    calendar.locale = Locale(identifier: "ru_Ru")
    return calendar
}

extension Date {
    func getDayOfWeek() -> String {
        return calendarCurrent.weekdaySymbols[calendarCurrent.component(.weekday, from: self) - 1].replacingOccurrences(of: "а", with: "у")
    }
    
    func getNumOfMonth() -> Int {
        return calendarCurrent.component(.day, from: self)
    }
    
    func getNameOfMonth() -> String {
        return calendarCurrent.monthSymbols[calendarCurrent.component(.month, from: self) - 1]
    }
    
    func getNextDate() -> Date {
        let today = calendarCurrent.startOfDay(for: Date())
        let date = calendarCurrent.startOfDay(for: self)
        let component = calendarCurrent.dateComponents([.day, .month], from: date)
        if calendarCurrent.dateComponents([.day, .month, .year], from: today) == calendarCurrent.dateComponents([.day, .month, .year], from: date) {
            return Date()
        }
        
        return calendarCurrent.nextDate(after: today,
                                        matching: component,
                                        matchingPolicy: .nextTimePreservingSmallerComponents) ?? Date()
    }
    
    func daysLeft() -> Int {
        let today = calendarCurrent.startOfDay(for: Date())
        guard let daysLeft = calendarCurrent.dateComponents([.day], from: today, to: self).day else { return 0 }
        return daysLeft - 1
    }
    
    func ageOfUser() -> Int {
        let nextDate = calendarCurrent.startOfDay(for: getNextDate())
        print(nextDate)
        let age = calendarCurrent.dateComponents([.year], from: self, to: nextDate).year ?? 0
        return age + 1
    }
}
