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
        emailTextField.backgroundColor = .lightGray
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
        passwordTextField.backgroundColor = .lightGray
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }

}

