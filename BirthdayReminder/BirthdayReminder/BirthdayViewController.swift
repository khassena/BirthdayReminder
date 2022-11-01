//
//  SecondViewController.swift
//  UIPickerView
//
//  Created by Amanzhan Zharkynuly on 26.09.2022.
//

import UIKit

class BirthdayViewController: UIViewController {

    private lazy var generalSV = UIStackView.createStackView(views: [],
                                                            axis: .vertical)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Birthday"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(addVC))
        view.addSubview(generalSV)

        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            generalSV.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            generalSV.topAnchor.constraint(equalTo: margin.topAnchor, constant: 30),
            margin.trailingAnchor.constraint(equalTo: generalSV.trailingAnchor),
        ])
    }
    
    @objc func addVC() {
        let thirdVC = NewPersonViewController()
        let navVC = UINavigationController(rootViewController: thirdVC)
        navVC.isModalInPresentation = true
        thirdVC.delegate = self
        present(navVC, animated: true)
    }
    
}

extension BirthdayViewController: UserProfileDelegate {
    func sendUserProfile(image: UIImage, name: String, date: Birthday, gender: String) {
        let userSV = UserStackView()
        userSV.setupView(image: image, name: name, date: date, gender: gender)
        generalSV.addArrangedSubview(userSV)
    }

}
