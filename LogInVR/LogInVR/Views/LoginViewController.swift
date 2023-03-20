//
//  ViewController.swift
//  LogInVR
//
//  Created by Uri on 20/3/23.
//

import UIKit

class LoginViewController: UIViewController {

    var safeArea: UILayoutGuide!
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var loginButton = UIButton()
    var forgotPasswordButton = UIButton()
    var eyeButton = UIButton()
    private var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginView()
    }

    func setupLoginView() {
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .white
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupForgotPasswordButton()
        setupEyeButton()
    }
    
    func setupEmailTextField(){
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -100),
            emailTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.widthAnchor.constraint(equalToConstant: 330),
        ])
        
        emailTextField.layer.cornerRadius = 5.0
        emailTextField.backgroundColor = .lightGray.withAlphaComponent(0.5)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func setupPasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.widthAnchor.constraint(equalToConstant: 330),
        ])
        
        passwordTextField.layer.cornerRadius = 5.0
        passwordTextField.backgroundColor = .lightGray.withAlphaComponent(0.5)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func setupLoginButton() {
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            loginButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalToConstant: 330),
        ])

        loginButton.layer.cornerRadius = 10
        loginButton.backgroundColor = .blue
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        //add target - print for testing
    }
    
    func setupForgotPasswordButton() {
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 50),
            forgotPasswordButton.widthAnchor.constraint(equalToConstant: 330),
        ])

        forgotPasswordButton.layer.cornerRadius = 10
        forgotPasswordButton.backgroundColor = .blue
        forgotPasswordButton.setTitle("Forgot password?", for: .normal)
        forgotPasswordButton.setTitleColor(.white, for: .normal)
        //add target - print for testing
    }
    
    func setupEyeButton(){
        view.addSubview(eyeButton)
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            eyeButton.topAnchor.constraint(equalTo: passwordTextField.topAnchor),
            eyeButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -5),
            eyeButton.heightAnchor.constraint(equalToConstant: 50),
            eyeButton.widthAnchor.constraint(equalToConstant: 20),
        ])
        
        eyeButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        eyeButton.tintColor = .blue
        //add target - print for testing
    }

}

