//
//  StableCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 20/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol AddStableCoordinating {
    func begin() -> AddStableViewControlling & UIViewController
    func done()
}

class AddStableCoordinator: AddStableCoordinating {
    
    private let resolver: DependencyResolving
    private weak var navController: UINavigationController?
    
    init(navController: UINavigationController, resolver: DependencyResolving) {
        self.navController = navController
        self.resolver = resolver
    }
    
    deinit {
        print("ADD STABLE DEINIT")
    }
    
    func begin() -> AddStableViewControlling & UIViewController {
        var viewController = resolver.resolveAddStableScene()
        viewController.coordinator = self
        return viewController
    }
    
    func done() {
        navController?.dismiss(animated: true, completion: nil)
    }
}
