//
//  BottomLine.swift
//  UIPickerView
//
//  Created by Amanzhan Zharkynuly on 27.09.2022.
//

import UIKit

class BottomLineTF: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomLine()
    }
    
     
}
