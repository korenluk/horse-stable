//
//  Register.swift
//  HorseStable
//
//  Created by Lukas Korinek on 09/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

final class RegisterViewModel: RegisterViewModeling {
    weak var delegate: RegisterViewModelingDelegate?

    private var isAuthenticating: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isAuthenticating)
        }
    }

    private let authService: AuthService


    init(authService: AuthService) {
        self.authService = authService
    }
    
    func register(name: String, username: String, password: String) {
        guard !isAuthenticating else {
            return
        }

        isAuthenticating = true
        authService.register(name: name, username: username, password: password) { [weak self] result in
            guard let self = self else {
                return
            }
            
            self.isAuthenticating = false

            switch result {
            case .success(_):
                self.delegate?.didRegister()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}
