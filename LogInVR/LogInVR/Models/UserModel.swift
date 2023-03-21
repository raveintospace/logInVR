//
//  UserModel.swift
//  LogInVR
//
//  Created by Uri on 21/3/23.
//

import Foundation

struct UserModel : Decodable{
    let users: [Users]?
    
    struct Users: Decodable{
        let id: String
        let name: String
        let email: String
        let password: String
        let accessToken: String
    }
}
