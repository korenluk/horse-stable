//
//  SettingsViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 07/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

final class SettingsViewModel: SettingsViewModeling {
    weak var delegate: SettingsViewModelingDelegate?

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
    
    func logout() {
        guard !isAuthenticating else {
            return
        }

        isAuthenticating = true
        authService.logout() { [weak self] result in
            guard let self = self else {
                return
            }
            
            self.isAuthenticating = false
            UserDefaults.standard.removeObject(forKey: "userID")
            switch result {
            case let .success(text):
                print(text)
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}
