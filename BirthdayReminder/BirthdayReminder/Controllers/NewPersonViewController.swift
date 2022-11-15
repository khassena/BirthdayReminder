//
//  ThirdViewController.swift
//  UIPickerView
//
//  Created by Amanzhan Zharkynuly on 26.09.2022.
//

import UIKit

protocol UserProfileDelegate: AnyObject {
    func sendUserProfile(image: UIImage, name: String, date: Birthday, gender: String)
}

enum Gender: String, CaseIterable {
    case male = "Мужчина"
    case female = "Женщина"
}

class NewPersonViewController: UIViewController {

    let colorBlue = UIColor(red: 174/255, green: 197/255, blue: 246/255, alpha: 1)
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "user")
        imageView.frame.size.width = 160
        imageView.frame.size.height = 160
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let buttonChangePhoto: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Изменить фото", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var labelName = UILabel.createLabel(text: "Имя",
                                                     color: colorBlue,
                                                     fontSize: 17,
                                                     style: "bold")
    private lazy var labelDate = UILabel.createLabel(text: "Дата",
                                                     color: colorBlue,
                                                     fontSize: 17,
                                                     style: "bold")
    private lazy var labelAge = UILabel.createLabel(text: "Возраст",
                                                     color: colorBlue,
                                                     fontSize: 17,
                                                    style: "bold")
    private lazy var labelGender = UILabel.createLabel(text: "Пол",
                                                     color: colorBlue,
                                                     fontSize: 17,
                                                       style: "bold")
    private lazy var labelInsta = UILabel.createLabel(text: "Instagram",
                                                     color: colorBlue,
                                                     fontSize: 17,
                                                      style: "bold")
    private lazy var textFieldName = UITextField.createTextField(placeholder: "Введите имя")
    private lazy var textFieldDate = UITextField.createTextField(placeholder: "Введите дату")
    private lazy var textFieldAge = UITextField.createTextField(placeholder: "Добавить")
    private lazy var textFieldGender = UITextField.createTextField(placeholder: "Добавить")
    private lazy var textFieldInsta = UITextField.createTextField(placeholder: "Добавить")
    private lazy var rootStackView = UIStackView.createStackView(views: [labelName, textFieldName, labelDate,
                                                                         textFieldDate, labelAge, textFieldAge,
                                                                         labelGender, textFieldGender, labelInsta,
                                                                         textFieldInsta], axis: .vertical)
    private let pickerDate = UIDatePicker()
    private lazy var agePickerView = UIPickerView.createPickerView(textFieldAge, tag: 1)
    private lazy var genderPickerView = UIPickerView.createPickerView(textFieldGender, tag: 2)
    private var ageValue: String = ""
    private var genderValue: String = ""
    
    weak var delegate: UserProfileDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        instaAlert()
        self.hideKeyboardWhenTappedAround()
    }
    
    private func setupView() {
        view.addSubview(imageView)
        view.addSubview(buttonChangePhoto)
        view.addSubview(rootStackView)
        let margin = view.layoutMarginsGuide
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(dismissScreen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(createUser))
        buttonChangePhoto.addTarget(self, action: #selector(changePhoto), for: .touchUpInside)
        // date picker settings
        pickerDate.datePickerMode = .date
        pickerDate.locale = Locale(identifier: "ru_Ru")
        textFieldDate.inputView = pickerDate
        pickerDate.preferredDatePickerStyle = .wheels
        createToolBar(textFieldDate, #selector(setDate))
        
        // age pickerView settings
        agePickerView.dataSource = self
        agePickerView.delegate = self
        createToolBar(textFieldAge, #selector(setAge))
        
        // gender picker settings
        genderPickerView.dataSource = self
        genderPickerView.delegate = self
        textFieldGender.inputView = genderPickerView
        createToolBar(textFieldGender, #selector(setGender))
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: margin.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 160),
            imageView.heightAnchor.constraint(equalToConstant: 160),
            imageView.centerXAnchor.constraint(equalTo: margin.centerXAnchor),
            
            buttonChangePhoto.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            buttonChangePhoto.centerXAnchor.constraint(equalTo: margin.centerXAnchor),
            
            rootStackView.topAnchor.constraint(equalTo: buttonChangePhoto.bottomAnchor, constant: 20),
            rootStackView.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 8),
            margin.trailingAnchor.constraint(equalTo: rootStackView.trailingAnchor, constant: 8)
        ])
        
    }
    
    func instaAlert() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(alertForInsta))
        textFieldInsta.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func dismissScreen() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func createUser() {
        guard let image = imageView.image else { return }
        let birthday = Birthday(dateOfBirth: pickerDate.date)
        delegate?.sendUserProfile(image: image,
                                  name: textFieldName.text ?? "",
                                  date: birthday,
                                  gender: textFieldGender.text ?? "")
        dismiss(animated: true, completion: nil)
    }
    
    @objc func setDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        textFieldDate.text = formatter.string(from: pickerDate.date)
        print(pickerDate.date.getNumOfMonth())
        view.endEditing(true)
    }
    
    @objc func setAge() {
        textFieldAge.text = ageValue
        view.endEditing(true)
    }
    
    @objc func setGender() {
        textFieldGender.text = genderValue
        view.endEditing(true)
    }
    
    @objc func changePhoto() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @objc func alertForInsta() {
        let alert = UIAlertController(title: "Введите username instagram",
                                                message: "",
                                                preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Готово",
                                   style: .default) { action in
            let text = alert.textFields?.first?.text
            self.textFieldInsta.text = "@" + text!
        }
        let actionCancel = UIAlertAction(title: "Отмена",
                                   style: .default) { action in
            alert.dismiss(animated: true)
        }
        alert.addTextField(configurationHandler: nil)
        alert.addAction(actionCancel)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func createToolBar(_ textField: UITextField ,_ action: Selector) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButtonDate = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: action)
        toolBar.setItems([doneButtonDate], animated: true)
        textField.inputAccessoryView = toolBar
    }

}

extension UIPickerView {
    static func createPickerView(_ textField: UITextField, tag: Int) -> UIPickerView {
        let pickerView = UIPickerView()
        textField.inputView = pickerView
        pickerView.tag = tag
        return pickerView
    }
}

extension NewPersonViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1: return 100
        case 2: return Gender.allCases.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            ageValue = "\(row + 1)"
            genderValue = "\(Gender.allCases[row].rawValue)"
        }
        switch pickerView.tag {
        case 1: return "\(row + 1)"
        case 2: return Gender.allCases[row].rawValue
        default: return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1: ageValue = "\(row + 1)"
        case 2: genderValue = "\(Gender.allCases[row].rawValue)"
        default: return
        }
    }
}

extension NewPersonViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            imageView.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
