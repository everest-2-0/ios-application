//
//  RegistrationViewController.swift
//  ScanShape
//
//  Created by Vadim on 04.02.2025.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var anotherMethodButton: UIButton!
    @IBOutlet weak var sexButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkBoxImageView: UIImageView!
    @IBOutlet weak var loginTextFieldContainer: UIView!
    @IBOutlet weak var passwordTextFieldContainer: UIView!
    @IBOutlet weak var nameTextFieldContainer: UIView!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var eyeImageView: UIImageView!
    @IBOutlet weak var rulesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCreateButton()
        configureSexButton()
        configureNameTextField()
        configureLoginTextField()
        configurePasswordTextField()
        configureRulesLabel()
        configureEyeImageView()
    }
    
    private func configureRulesLabel(){
        let fullText = "Согласен с правилами приложения и политикой конфиденциальности"
        let attributedString = NSMutableAttributedString(string: fullText)

        let rangeRule = (fullText as NSString).range(of: "правилами")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: rangeRule)
        
        let rangePolicy = (fullText as NSString).range(of: "политикой конфиденциальности")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: rangePolicy)

        rulesLabel.attributedText = attributedString
    }
    
    private func configureEyeImageView() {
        eyeImageView.isUserInteractionEnabled = true
        eyeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(eyeImageTapped)))
    }
    
    private func configureNameTextField(){
        nameTextFieldContainer.layer.cornerRadius = 8
        nameTextField.layer.cornerRadius = 8
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Ваше имя", attributes: [
            .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5),
            .font: UIFont(name: "Inter Bold", size: 16)!
        ])
        nameTextField.font = UIFont(name: "Inter Bold", size: 16)
        nameTextField.textColor = .white
    }
    
    private func configureLoginTextField(){
        loginTextFieldContainer.layer.cornerRadius = 8
        loginTextField.attributedPlaceholder = NSAttributedString(string: "Телефон", attributes: [
            .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5),
            .font: UIFont(name: "Inter Bold", size: 16)!
        ])
        loginTextField.font = UIFont(name: "Inter Bold", size: 16)
        loginTextField.textColor = .white
    }
    
    private func configurePasswordTextField(){
        passwordTextFieldContainer.layer.cornerRadius = 8
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [
            .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5),
            .font: UIFont(name: "Inter Bold", size: 16)!
        ])
        passwordTextField.font = UIFont(name: "Inter Bold", size: 16)
        passwordTextField.textColor = .white
    }
    
    private func configureCreateButton(){
        createButton.layer.cornerRadius = 8
        createButton.titleLabel?.textColor = .white
    }
    
    private func configureSexButton(){
        sexButton.layer.cornerRadius = 8
    }

    @IBAction func autorizationButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sexButtonTapped(_ sender: Any) {
        
        let newTitle = (sexButton.titleLabel!.text == "Ж") ? "М" : "Ж"
            
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Inter-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold),
            .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        ]
        
        let attributedTitle = NSAttributedString(string: newTitle, attributes: attributes)
        sexButton.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    @objc private func eyeImageTapped(){
        let currentText = passwordTextField.text
        passwordTextField.isSecureTextEntry.toggle()
        passwordTextField.text = currentText

    }
}
