//
//  SettingsCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 07/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol SettingsCoordinating {
    var logout: () -> Void { get }
    var changeStable: (() -> Void)? { get }
    func begin() -> UIViewController
}

class SettingsCoordinator: SettingsCoordinating {
    let logout: () -> Void
    var changeStable: (() -> Void)?
    
    private let resolver: DependencyResolving
    private weak var navController: UINavigationController?
    
    init(navController: UINavigationController, resolver: DependencyResolving, logout: @escaping () -> Void) {
        self.navController = navController
        self.resolver = resolver
        self.logout = logout
    }
    
    deinit {
        print("Settings DEINIT")
    }
    
    func begin() -> UIViewController {
        var viewController = resolver.resolveSettingsScene()
        viewController.coordinator = self
        return viewController
    }
    
}
