//
//  ViewController.swift
//  LogInVR
//  https://youtu.be/5AJrqBF7jaE - min 18 thursday
//  Created by Uri on 20/3/23.
//

import UIKit
import SwiftKeychainWrapper

class LoginViewController: UIViewController {

    var safeArea: UILayoutGuide!
    var personImageView = UIImageView()
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
        setupPersonImageView()
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupForgotPasswordButton()
        setupEyeButton()
    }
    
    func setupPersonImageView() {
        view.addSubview(personImageView)
        personImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            personImageView.topAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -250),
            personImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            personImageView.heightAnchor.constraint(equalToConstant: 100),
            personImageView.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        personImageView.image = UIImage(systemName: "person.badge.key.fill")
        personImageView.tintColor = .blue
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
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
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
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func setupLoginButton() {
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            loginButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
        ])

        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.blue, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
    }
    
    func setupForgotPasswordButton() {
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
        ])

        forgotPasswordButton.setTitle("Forgot password?", for: .normal)
        forgotPasswordButton.setTitleColor(.blue, for: .normal)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonAction), for: .touchUpInside)
    }
    
    func setupEyeButton(){
        view.addSubview(eyeButton)
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            eyeButton.topAnchor.constraint(equalTo: passwordTextField.topAnchor),
            eyeButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -5),
            eyeButton.heightAnchor.constraint(equalToConstant: 50),
            eyeButton.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        eyeButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        eyeButton.tintColor = .blue
        eyeButton.addTarget(self, action: #selector(eyeButtonAction), for: .touchUpInside)
    }
    
    // MARK: - Button actions
    @objc func loginButtonAction() {
        guard let users = Utils.parseJson(jsonName: "Login", model: UserModel.self) else {
            showAlert("Error getting JSON")
            return
        }
        // check if getUser values match input values
        guard let getUser = users.users?.filter({
            $0.password == passwordTextField.text! &&
            $0.email == emailTextField.text!}).first
        else {
            showAlert("Wrong credentials")
            return
        }
       
        saveUserData(user: getUser)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            // self.navigationController?.pushViewController(vc, animated: true) - not used, shows "back" button & swipe works
            view.window?.windowScene?.keyWindow?.rootViewController = vc
            view.window?.windowScene?.keyWindow?.makeKeyAndVisible()
        }
    }
    
    @objc func forgotPasswordButtonAction() {
        print("password button action")
    }
    
    @objc func eyeButtonAction() {
        print("eye button action")
    }
    
    // MARK: - Additional funcs
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            if action.style == .cancel {
                print("OK button pressed")
            }
        }))
        present(alert, animated: true)
    }
    
    func saveUserData(user: UserModel.Users) {
        KeychainWrapper.standard.set(user.id, forKey: "id")
        KeychainWrapper.standard.set(user.name, forKey: "name")
        KeychainWrapper.standard.set(user.email, forKey: "email")
        KeychainWrapper.standard.set(user.accessToken, forKey: "accessToken")
        
// defaults.set(user.email, forKey: "email")
    }

}

