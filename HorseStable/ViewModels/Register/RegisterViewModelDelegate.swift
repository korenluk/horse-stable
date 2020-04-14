//
//  RegisterViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 09/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

protocol RegisterViewModelingDelegate: class {
    func didUpdate(isBusy: Bool)
    func didRegister()
    func didFail(with error: Error)
}

protocol RegisterViewModeling: class {
    var delegate: RegisterViewModelingDelegate? { get set }
    
    func register(name: String, username: String, password: String)
}
