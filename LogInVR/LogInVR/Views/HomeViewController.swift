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
        userImageView.image = UIImage(systemName: "person.fill.checkmark")
        userImageView.tintColor = .green
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
        userIdLabel.layer.cornerRadius = 5.0
        userIdLabel.backgroundColor = .lightGray.withAlphaComponent(0.5)
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
        userNameLabel.layer.cornerRadius = 5.0
        userNameLabel.backgroundColor = .lightGray.withAlphaComponent(0.5)
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
        userEmailLabel.layer.cornerRadius = 5.0
        userEmailLabel.backgroundColor = .lightGray.withAlphaComponent(0.5)
    }
    
    func setupLogoutButton() {
        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: userEmailLabel.bottomAnchor, constant: 15),
            logoutButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
        ])

        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.blue, for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonAction), for: .touchUpInside)
    }
    
    @objc func logoutButtonAction() {
        print("Logout button action")
    }
    
    func setupUserData(){
        let id: String? = KeychainWrapper.standard.string(forKey: "id")
        let name: String? = KeychainWrapper.standard.string(forKey: "name")
        let email: String? = KeychainWrapper.standard.string(forKey: "email")
        let accessToken: String? = KeychainWrapper.standard.string(forKey: "accessToken")
        
        userIdLabel.text = id
        userNameLabel.text = name
        userEmailLabel.text = email
    }

}
