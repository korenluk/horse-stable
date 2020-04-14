//
//  User.swift
//  HorseStable
//
//  Created by Lukas Korinek on 07/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    var name: String
    var username: Int
}

struct UserResponse: Codable {
    let id: UUID
    var username: String
}

struct UserTokenResponse: Codable {
    let id: UUID
    let token: String
    let userID: UUID
}

struct UserLogout: Codable {
    let code: String?
}
