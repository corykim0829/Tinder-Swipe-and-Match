//
//  LoginController.swift
//  Tinder
//
//  Created by Cory Kim on 03/05/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol LoginControllerDelegate {
    func didFinishLogginIn()
}

class LoginController: UIViewController {
    
    var delegate: LoginControllerDelegate?

    let emailTextField: CustomTextField = {
        let tf = CustomTextField(padding: 24, height: 44)
        tf.placeholder = "Enter email"
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 24, height: 44)
        tf.placeholder = "Enter password"
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    @objc fileprivate func handleTextChange(textField: UITextField) {
        if textField == emailTextField {
            loginViewModel.email = textField.text
        } else {
            loginViewModel.password = textField.text
        }
    }
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .lightGray
        button.setTitleColor(.darkGray, for: .disabled)
        button.isEnabled = false
        button.layer.cornerRadius = 20
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let registeringHUD = JGProgressHUD(style: .dark)
    
    @objc fileprivate func handleLogin() {
        loginViewModel.performLogin { (err) in
            self.loginHUD.dismiss()
            if let err = err {
                self.showHUDWithError(error: err)
                return
            }
            self.dismiss(animated: true, completion: {
                self.delegate?.didFinishLogginIn()
            })
        }
    }
    
    lazy var verticalStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            emailTextField,
            passwordTextField,
            loginButton
            ])
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    let backToRegistrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back to Registration", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleBackToRegistration), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return button
    }()
    
    
    @objc fileprivate func handleBackToRegistration() {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func showHUDWithError(error: Error) {
        registeringHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed registration"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGradientLayer()
        setupLayout()
        setupBindables()
    }
    
    fileprivate let loginViewModel = LoginViewModel()
    fileprivate let loginHUD = JGProgressHUD(style: .dark)
    
    fileprivate func setupBindables() {
        loginViewModel.isFormValid.bind { [unowned self] (isFormValid) in
            guard let isFormValid = isFormValid else { return }
            self.loginButton.isEnabled = isFormValid
            self.loginButton.backgroundColor = isFormValid ? #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) : .lightGray
        }
        loginViewModel.isLoggingIn.bind { [unowned self] (isLogginIn) in
            if isLogginIn == true {
                self.loginHUD.textLabel.text = "Login"
                self.loginHUD.show(in: self.view)
            } else {
                self.loginHUD.dismiss()
            }
        }
    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let topColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
        // make sure to use cgColor
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
    
    fileprivate func setupLayout() {
        view.addSubview(verticalStackView)
        verticalStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 44, bottom: 0, right: 44))
        verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(backToRegistrationButton)
        backToRegistrationButton.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil)
        backToRegistrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
