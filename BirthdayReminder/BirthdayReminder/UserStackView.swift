//
//  UserStackView.swift
//  UIPickerView
//
//  Created by Amanzhan Zharkynuly on 21.10.2022.
//

import UIKit

class UserStackView: UIStackView {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame.size.width = 80
        imageView.frame.size.height = 80
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let nameLabel = UILabel.createLabel(text: "",
                                                color: .black,
                                                fontSize: 20,
                                                style: "")
    private let daysToBirthday = UILabel.createLabel(text: "",
                                                     color: .gray,
                                                     fontSize: 17,
                                                     style: "regular")
    private let birthdayDescripton = UILabel.createLabel(text: "",
                                                         color: .gray,
                                                         fontSize: 17,
                                                         style: "regular")
    private lazy var firstLabelsSV = UIStackView.createStackView(views: [nameLabel, daysToBirthday],
                                                                 axis: .horizontal)
    private lazy var secondLabelsSV = UIStackView.createStackView(views: [firstLabelsSV, birthdayDescripton],
                                                                  axis: .vertical)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomLine()
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func setupView(image: UIImage, name: String, date: Birthday, gender: String) {
        self.axis = axis
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 10.0
        
        birthdayDescripton.numberOfLines = 0
        
        imageView.image = image
        nameLabel.text = name
        birthdayDescripton.text = "\(date.dayOfBirth) \(date.monthOfBirth), \(date.weekOfBirth.daysOfWeekGrammar()) \(gender.genderGrammar()) исполнится \(date.age.ageGrammar())"
        daysToBirthday.text = "\(date.daysLeft.daysLeftGrammar())"
        
        addArrangedSubview(imageView)
        addArrangedSubview(secondLabelsSV)
    }
    
}
