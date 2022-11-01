//
//  ViewController.swift
//  UIPickerView
//
//  Created by Amanzhan Zharkynuly on 21.09.2022.
//

import UIKit


class ViewController: UIViewController {
    
    let colorBlue = UIColor(red: 174/255, green: 197/255, blue: 246/255, alpha: 1)
    
    private lazy var logoLabel = UILabel.createLabel(text: "Birthday Reminder",
                                                     color: colorBlue,
                                                     fontSize: 20,
                                                     style: "bold")
    
    private let signInLabel = UILabel.createLabel(text: "Sign In",
                                                  color: .black,
                                                  fontSize: 32,
                                                  style: "bold")
    
    private lazy var emailLabel = UILabel.createLabel(text: "Email",
                                                      color: colorBlue,
                                                      fontSize: 17,
                                                      style: "bold")
    
    private lazy var passwordLabel = UILabel.createLabel(text: "Password",
                                                         color: colorBlue,
                                                         fontSize: 17,
                                                         style: "bold")
    
    private let emailTextField = UITextField.createTextField(placeholder: "example@gmail.com")
    private let passwordTextField = UITextField.createTextField(placeholder: "qwerty123")
    private let errorMessage = UILabel.createLabel(text: "", color: .red, fontSize: 17, style: "bold")
    private lazy var textFieldsArray = [emailTextField, passwordTextField]
    private lazy var signInStackView = UIStackView.createStackView(views: [emailLabel, emailTextField, passwordLabel, passwordTextField], axis: .vertical)
    private let imageIcon = UIImageView()
    private let faceIDLabel = UILabel.createLabel(text: "Вход по Face ID", color: .black, fontSize: 17, style: "bold")
    private let faceIDSwitch = UISwitch()
    private lazy var faceIDStackView = UIStackView.createStackView(views: [faceIDLabel, faceIDSwitch], axis: .horizontal)
    private lazy var buttonSignIn: UIButton = {
       let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = colorBlue
        button.setTitle("Войти", for: .normal)
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    var iconClick = true
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        eyeSequrePassword()
        self.hideKeyboardWhenTappedAround() 
    }

    @objc private func checkTextFields() {
        for texts in textFieldsArray {
            guard let temp = texts.text, temp.count != 0 else {
                return getError("Please enter \(texts.restorationIdentifier!)")
            }
        }
        errorMessage.isHidden = true
        let secondVC = BirthdayViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    private func getError(_ message: String) {
        errorMessage.text = message
        errorMessage.isHidden = false
        buttonSignIn.shake()
    }
    
    // MARK: Eye sequre for password
    private func eyeSequrePassword() {
        errorMessage.isHidden = true
        imageIcon.image = UIImage(named: "eyeClosed")
        imageIcon.frame = CGRect(x: 0, y: 0, width: UIImage(named: "eyeClosed")!.size.width, height: UIImage(named: "eyeClosed")!.size.height)
        passwordTextField.rightView = imageIcon
        passwordTextField.rightViewMode = .always
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if iconClick {
            iconClick = false
            imageIcon.image = UIImage(named: "eyeOpened")
        } else {
            iconClick = true
            imageIcon.image = UIImage(named: "eyeClosed")
        }
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    private func setupView() {
        view.addSubview(logoLabel)
        view.addSubview(signInLabel)
        view.addSubview(signInStackView)
        logoLabel.layer.borderWidth = 2
        logoLabel.textAlignment = .center
        passwordTextField.isSecureTextEntry = true
        view.addSubview(signInStackView)
        view.addSubview(faceIDStackView)
        view.addSubview(buttonSignIn)
        view.addSubview(errorMessage)
        let margin = view.layoutMarginsGuide
        emailTextField.restorationIdentifier = "Email"
        passwordTextField.restorationIdentifier = "Password"
        buttonSignIn.addTarget(self, action: #selector(checkTextFields), for: .touchUpInside)
        
        
        
        NSLayoutConstraint.activate([
            logoLabel.widthAnchor.constraint(equalToConstant: 220),
            logoLabel.heightAnchor.constraint(equalToConstant: 100),
            logoLabel.topAnchor.constraint(equalTo: margin.topAnchor, constant: 50),
            logoLabel.centerXAnchor.constraint(equalTo: margin.centerXAnchor),

            signInLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 30),
            signInLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 70),
            signInLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 70),
            
            signInStackView.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 12),
            signInStackView.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 20),
            margin.trailingAnchor.constraint(equalTo: signInStackView.trailingAnchor, constant: 40),
        
            faceIDStackView.topAnchor.constraint(equalTo: signInStackView.bottomAnchor, constant: 35),
            faceIDStackView.centerXAnchor.constraint(equalTo: margin.centerXAnchor),
            
            buttonSignIn.topAnchor.constraint(equalTo: faceIDStackView.bottomAnchor, constant: 30),
            buttonSignIn.leadingAnchor.constraint(lessThanOrEqualTo: margin.leadingAnchor, constant: 32),
            margin.trailingAnchor.constraint(lessThanOrEqualTo: buttonSignIn.trailingAnchor, constant: 40),
            buttonSignIn.heightAnchor.constraint(equalToConstant: 50),
            
            errorMessage.topAnchor.constraint(equalTo: buttonSignIn.bottomAnchor, constant: 20),
            errorMessage.centerXAnchor.constraint(equalTo: margin.centerXAnchor)
        ])
    }

}

extension UILabel {
    static func createLabel(text: String, color: UIColor, fontSize: CGFloat, style: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        if style == "bold" {
            label.font = UIFont.boldSystemFont(ofSize: fontSize)
        } else {
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
        label.textColor = color
        return label
    }
}

extension UITextField {
    static func createTextField(placeholder: String) -> UITextField {
        let textField = BottomLineTF()
        textField.placeholder = placeholder
        return textField
    }
}

extension UIView {
    func bottomLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height + 5.0 , width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        self.layer.addSublayer(bottomLine)
    }
}

extension UIStackView {
    static func createStackView(views: [UIView], axis: NSLayoutConstraint.Axis) -> UIStackView {
        var stackView = UIStackView()
        stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10.0
        for item in stackView.subviews {
            if let textField = item as? UITextField {
                stackView.setCustomSpacing(25, after: textField)
            }
        }
        return stackView
    }
}

extension UIButton {
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: nil)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

