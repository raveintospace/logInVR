//
//  HomeViewController.swift
//  LogInVR
//
//  Created by Uri on 21/3/23.
//

import UIKit
import SwiftKeychainWrapper

class HomeViewController: UIViewController {

    var safeArea: UILayoutGuide!
    var userImageView = UIImageView()
    var userIdLabel = UILabel()
    var userNameLabel = UILabel()
    var userEmailLabel = UILabel()
    var logoutButton = UIButton()
    private var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // print("email: ", defaults.string(forKey: "email"))
        setupHomeView()
        setupUserData()
    }
    
    func setupHomeView() {
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .white
        setupUserImageView()
        setupUserIdLabel()
        setupUserNameLabel()
        setupUserEmailLabel()
        setupLogoutButton()
    }
    
    func setupUserImageView() {
        view.addSubview(userImageView)
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -250),
            userImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 100),
            userImageView.widthAnchor.constraint(equalToConstant: 125),
        ])
        userImageView.standardSetup(systemName: "person.fill.checkmark", color: .green)
    }

    func setupUserIdLabel(){
        view.addSubview(userIdLabel)
        userIdLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userIdLabel.topAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -100),
            userIdLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            userIdLabel.heightAnchor.constraint(equalToConstant: 50),
            userIdLabel.widthAnchor.constraint(equalToConstant: 330),
        ])
        userIdLabel.standardSetup()
    }
    
    func setupUserNameLabel() {
        view.addSubview(userNameLabel)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: userIdLabel.bottomAnchor, constant: 10),
            userNameLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            userNameLabel.heightAnchor.constraint(equalToConstant: 50),
            userNameLabel.widthAnchor.constraint(equalToConstant: 330),
        ])
        userNameLabel.standardSetup()
    }
    
    func setupUserEmailLabel(){
        view.addSubview(userEmailLabel)
        userEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userEmailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            userEmailLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            userEmailLabel.heightAnchor.constraint(equalToConstant: 50),
            userEmailLabel.widthAnchor.constraint(equalToConstant: 330),
        ])
        userEmailLabel.standardSetup()
    }
    
    func setupLogoutButton() {
        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: userEmailLabel.bottomAnchor, constant: 15),
            logoutButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
        ])
        logoutButton.standardSetup(title: "Logout")
        logoutButton.addTarget(self, action: #selector(logoutButtonAction), for: .touchUpInside)
    }
    
    @objc func logoutButtonAction() {
        KeychainWrapper.standard.removeObject(forKey: "id")
        KeychainWrapper.standard.removeObject(forKey: "name")
        KeychainWrapper.standard.removeObject(forKey: "email")
        KeychainWrapper.standard.removeObject(forKey: "accessToken")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            // self.navigationController?.pushViewController(vc, animated: true) - not used, shows "back" button & swipe works
            view.window?.windowScene?.keyWindow?.rootViewController = vc
            view.window?.windowScene?.keyWindow?.makeKeyAndVisible()
        }
    }
    
    func setupUserData(){
        let id: String? = KeychainWrapper.standard.string(forKey: "id")
        let name: String? = KeychainWrapper.standard.string(forKey: "name")
        let email: String? = KeychainWrapper.standard.string(forKey: "email")
        let accessToken: String? = KeychainWrapper.standard.string(forKey: "accessToken")
        
        userIdLabel.text = "Id: " + id!
        userNameLabel.text = "Name: " + name!
        userEmailLabel.text = "Email: " + email!
        print("AccessToken: " + accessToken!)
    }

}
