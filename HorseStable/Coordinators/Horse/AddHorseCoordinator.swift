//
//  AddHorseCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 29/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol AddHorseCoordinating: Coordinating {
    func done()
}

class AddHorseCoordinator: AddHorseCoordinating {
    private let resolver: DependencyResolving
    private weak var navController: UINavigationController?
    
    init(navController: UINavigationController, resolver: DependencyResolving) {
        self.navController = navController
        self.resolver = resolver
    }
    
    deinit {
        print("ADD HORSE DEINIT")
    }
    
    func begin() -> UIViewController{
        var viewController = resolver.resolveAddHorseScene()
        viewController.coordinator = self
        return viewController
    }
    
    func done() {
        navController?.popViewController(animated: true)
    }
}
