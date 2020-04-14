//
//  HorseDetailCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 29/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol HorseDetailCoordinating: Coordinating {

}

class HorseDetailCoordinator: HorseDetailCoordinating {
    private let resolver: DependencyResolving
    private let horse: Horse
    private weak var navController: UINavigationController?
    
    init(horse: Horse, navController: UINavigationController ,resolver: DependencyResolving) {
        self.horse = horse
        self.resolver = resolver
        self.navController = navController
    }
    
    deinit {
        print("HORSE DETAIL \(horse.id) DEINIT")
    }
    
    func begin() -> UIViewController {
        var viewController = resolver.resolveHorseDetailScene(horse: horse)
        viewController.coordinator = self
        return viewController
    }
}
