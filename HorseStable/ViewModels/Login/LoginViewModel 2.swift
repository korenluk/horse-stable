//
//  LoginViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 07/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

final class LoginViewModel: LoginViewModeling {
    weak var delegate: LoginViewModelingDelegate?

    private var isAuthenticating: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isAuthenticating)
        }
    }

    private let authService: AuthService
    private let keychainManager: KeychainManaging

    init(authService: AuthService, keychainManager: KeychainManaging) {
        self.authService = authService
        self.keychainManager = keychainManager
    }

    func login(username: String, password: String) {
        guard !isAuthenticating else {
            return
        }

        isAuthenticating = true
        authService.login(username: username, password: password) { [weak self] result in
            guard let self = self else {
                return
            }
            
            self.isAuthenticating = false

            switch result {
            case let .success(userResponse):
                self.keychainManager.store(value: userResponse.token, forKey: .accessToken)
                UserDefaults.standard.set(userResponse.userID.uuidString, forKey: "userID")
                self.delegate?.didAuthenticate()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}
