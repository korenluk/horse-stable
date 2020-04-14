//
//  AddWorkPlaceCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 10/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

protocol AddWorkPlaceCoordinating: Coordinating {
    func done()
}

class AddWorkPlaceCoordinator: AddWorkPlaceCoordinating {
    private let resolver: DependencyResolving
    private weak var navController: UINavigationController?
    
    init(navController: UINavigationController, resolver: DependencyResolving) {
        self.navController = navController
        self.resolver = resolver
    }
    
    deinit {
        print("ADD WorkPlace DEINIT")
    }
    
    func begin() -> UIViewController{
        var viewController = resolver.resolveAddWorkPlaceScene()
        viewController.coordinator = self
        return viewController
    }
    
    func done() {
        navController?.popViewController(animated: true)
    }
}
