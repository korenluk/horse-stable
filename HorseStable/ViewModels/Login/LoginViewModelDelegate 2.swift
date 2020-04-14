//
//  LoginViewModeling.swift
//  HorseStable
//
//  Created by Lukas Korinek on 07/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

protocol LoginViewModelingDelegate: class {
    func didUpdate(isBusy: Bool)
    func didAuthenticate()
    func didFail(with error: Error)
}

protocol LoginViewModeling: class {
    var delegate: LoginViewModelingDelegate? { get set }

    func login(username: String, password: String)
}
