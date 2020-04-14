//
//  AddFeedTypeCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 04/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

protocol AddFeedTypeCoordinating: Coordinating {
    func done()
}

class AddFeedTypeCoordinator: AddFeedTypeCoordinating {
    private let resolver: DependencyResolving
    private weak var navController: UINavigationController?
    
    init(navController: UINavigationController, resolver: DependencyResolving) {
        self.navController = navController
        self.resolver = resolver
    }
    
    deinit {
        print("ADD FEEDTYPE DEINIT")
    }
    
    func begin() -> UIViewController{
        var viewController = resolver.resolveAddFeedTypeScene()
        viewController.coordinator = self
        return viewController
    }
    
    func done() {
        navController?.popViewController(animated: true)
    }
}
