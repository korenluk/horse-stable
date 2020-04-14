//
//  AuthService.swift
//  HorseStable
//
//  Created by Lukas Korinek on 07/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Alamofire
import Foundation

final class AuthService {
    let apiManager: APIManaging
    let apiAuthManager: APIManaging

    init(apiManager: APIManaging, apiAuthManager: APIManaging) {
        self.apiManager = apiManager
        self.apiAuthManager = apiAuthManager
    }

    func login(username: String, password: String, completion: @escaping (Swift.Result<UserTokenResponse, Error>) -> Void) {
        apiManager.request(request: AuthRouter.login(username: username, password: password), completion: completion)
    }

    func register(name: String, username: String, password: String, completion: @escaping (Swift.Result<UserResponse, Error>) -> Void) {
        apiManager.request(request: AuthRouter.register(name: name, username: username, password: password), completion: completion)
    }
    
    func logout(completion: @escaping (Swift.Result<UserLogout,Error>)-> Void) {
        apiAuthManager.request(request: AuthRouter.logout, completion: completion)
    }
    
    func userStables(identifier: String, completion: @escaping (Swift.Result<[Stable],Error>) -> Void) {
        apiAuthManager.request(request: AuthRouter.getStables(identifier: identifier), completion: completion)
    }
}
