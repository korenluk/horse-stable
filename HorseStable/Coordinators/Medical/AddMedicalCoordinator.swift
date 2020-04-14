//
//  AddMedicalCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 26/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol AddMedicalCoordinating {
    func begin() -> AddMedicalViewControlling & UIViewController
    func done()
}

class AddMedicalCoordinator: AddMedicalCoordinating {
    
    private let resolver: DependencyResolving
    private weak var navController: UINavigationController?
    private let horse: Horse
    
    init(horse: Horse, navController: UINavigationController, resolver: DependencyResolving) {
        self.navController = navController
        self.resolver = resolver
        self.horse = horse
    }
    
    deinit {
        print("ADD MEDICAL DEINIT")
    }
    
    func begin() -> AddMedicalViewControlling & UIViewController {
        var viewController = resolver.resolveAddMedicalScene(horse: horse)
        viewController.coordinator = self
        return viewController
    }
    
    func done() {
        navController?.popViewController(animated: true)
    }
}
