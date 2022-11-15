//
//  Birthday.swift
//  UIPickerView
//
//  Created by Amanzhan Zharkynuly on 24.10.2022.
//

import UIKit

class Birthday {
    var dateOfBirth: Date
    var nextDateOfBirth: Date
    var monthOfBirth: String
    var dayOfBirth: Int
    var weekOfBirth: String
    var daysLeft: Int
    var age: Int
    
    init(dateOfBirth: Date) {
        self.dateOfBirth = dateOfBirth
        self.nextDateOfBirth = dateOfBirth.getNextDate()
        self.monthOfBirth = dateOfBirth.getNameOfMonth()
        self.dayOfBirth = dateOfBirth.getNumOfMonth()
        self.weekOfBirth = self.nextDateOfBirth.getDayOfWeek()
        self.daysLeft = self.nextDateOfBirth.daysLeft()
        self.age = dateOfBirth.ageOfUser()
    }
}
