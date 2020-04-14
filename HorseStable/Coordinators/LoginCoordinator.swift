//
//  LoginCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 09/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol LoginCoordinating {
    func begin() -> LoginViewControlling & UIViewController
    func register()
    func done()
}

class LoginCoordinator: LoginCoordinating {
    
    private let resolver: DependencyResolving
    private weak var navController: UINavigationController?
    
    init(navController: UINavigationController, resolver: DependencyResolving) {
        self.navController = navController
        self.resolver = resolver
    }
    
    deinit {
        print("LOGIN COORDINATOR DEINIT")
    }
    
    func begin() -> LoginViewControlling & UIViewController {
        var viewController = resolver.resolveLoginScene()
        viewController.coordinator = self
        return viewController
    }
    
    func register() {
        var viewController = resolver.resolveRegisterScene()
        viewController.coordinator = self
        navController?.pushViewController(viewController, animated: true)
    }
    
    func done() {
        navController?.popViewController(animated: true)
    }
}
