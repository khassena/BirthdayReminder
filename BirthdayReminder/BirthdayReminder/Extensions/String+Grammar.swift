//
//  String+Grammar.swift
//  UIPickerView
//
//  Created by Amanzhan Zharkynuly on 25.10.2022.
//

import UIKit

extension String {
    func daysOfWeekGrammar() -> String {
        return self == "вторник" ? "во \(self)" : "в \(self)"
    }
    
    func genderGrammar() -> String {
        switch self {
        case "Мужчина": return "ему"
        case "Женщина": return "ей"
        default: return ""
        }
    }
}
