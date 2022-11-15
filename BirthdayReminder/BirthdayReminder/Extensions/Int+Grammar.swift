//
//  Int+Grammar.swift
//  UIPickerView
//
//  Created by Amanzhan Zharkynuly on 25.10.2022.
//

import UIKit

extension Int {
    func daysLeftGrammar() -> String {
        switch self {
        case -1: return "сегодня"
        case 0: return "завтра"
        case 1: return "послезавтра"
        case 3...5: return "\(self) дня"
        default: return "\(self) дней"
        }
    }
    
    func ageGrammar() -> String {
        if self % 100 == 1 {
            return "\(self) лет"
        } else if self % 10 == 1 {
            return "\(self) год"
        } else if (2...4).contains(self % 10) {
            return "\(self) года"
        } else {
            return "\(self)"
        }
    }
}

