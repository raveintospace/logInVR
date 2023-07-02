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
    var eyeButton = UIButton()
    private var defaults = UserDefaults.standard  // -> only to test how it works
    
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
        personImageView.standardSetup(systemName: "person.badge.key.fill", color: .blue)
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
        emailTextField.standardSetup(nameInField: "Email")
        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress
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
        passwordTextField.standardSetup(nameInField: "Password")
        passwordTextField.isSecureTextEntry = true
    }
    
    func setupLoginButton() {
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            loginButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
        ])
        loginButton.standardTextSetup(title: "Login")
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
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
        eyeButton.standardImageSetup(systemName: "eye.fill")
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
    
    @objc func eyeButtonAction() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        
        let icon: String = passwordTextField.isSecureTextEntry ? "eye.fill" : "eye.slash"
        eyeButton.setImage(UIImage(systemName: icon), for: .normal)
    }
    
    // MARK: - Additional funcs
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
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

