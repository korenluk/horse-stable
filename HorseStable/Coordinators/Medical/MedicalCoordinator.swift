//
//  MedicalCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 26/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol MedicalCoordinating {
    func add()
}

class MedicalCoordinator: MedicalCoordinating {
    private let resolver: DependencyResolving
    private weak var navController: UINavigationController?
    private let horse: Horse
    
    init(horse: Horse, navController: UINavigationController, resolver: DependencyResolving) {
        self.navController = navController
        self.resolver = resolver
        self.horse = horse
    }
    
    deinit {
        print("MEDICAL DEINIT")
    }
    
    func begin() -> MedicalViewControlling & UIViewController {
        var viewController = resolver.resolveMedicalScene(horse: horse)
        viewController.coordinator = self
        return viewController
    }
    
    func add(){
        let coordinator = AddMedicalCoordinator(horse: horse, navController: navController!, resolver: resolver)
        let viewController = coordinator.begin()
        navController?.pushViewController(viewController, animated: true)
    }
}
