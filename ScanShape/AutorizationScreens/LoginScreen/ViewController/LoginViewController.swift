//
//  ViewController.swift
//  ScanShape
//
//  Created by Vadim on 04.02.2025.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var anotherMethodButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginTextFieldContainer: UIView!
    @IBOutlet weak var passwordTextFieldContainer: UIView!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var eyeImageView: UIImageView!
    @IBOutlet weak var changePasswordButton: UIButton!
    
    let networkManager = NetworkManager.shared
    var gwtToket: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        configureCreateButton()
        configureLoginTextField()
        configurePasswordTextField()
        configureChangePasswordButton()
        configureEyeImageView()
    }
    
    private func configureEyeImageView() {
        eyeImageView.isUserInteractionEnabled = true
        eyeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(eyeImageTapped)))
    }
    
    @objc private func eyeImageTapped(){
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    private func configureChangePasswordButton(){
        let attributedString = NSAttributedString(
            string: "Восстановить пароль",
            attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue,
                         .font: UIFont(name: "Inter Regular", size: 14)!,
                         .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)]
        )

        changePasswordButton.setAttributedTitle(attributedString, for: .normal)
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
        enterButton.layer.cornerRadius = 8
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "RegistrationViewController", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "RegistrationVC") as? RegistrationViewController else {
            return
        }
        
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any){
        loginToApplication(number: loginTextField.text ?? "", password: passwordTextField.text ?? "")
    }
}

//MARK: - Network

extension LoginViewController{
    func loginToApplication(number: String, password: String){
        networkManager.loginToAccount(number: number, password: password) { [weak self] result in
            switch result{
            case .success(let token):
                self?.gwtToket = token
                print("login completed")
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}

//MARK: - Extension For Text Field

extension LoginViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if let nextTextField = textField.next as? UITextField{
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
