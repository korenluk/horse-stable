//
//  HorsesCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 29/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol HorsesCoordinating {
    func select(with horse: Horse)
    func add()
}

class HorsesCoordinator: HorsesCoordinating {
    private let resolver: DependencyResolving
    private weak var navController: UINavigationController?
    
    init(navController: UINavigationController, resolver: DependencyResolving) {
        self.navController = navController
        self.resolver = resolver
    }
    
    deinit {
        print("HORSES DEINIT")
    }
    
    func begin() -> UIViewController {
        var viewController = resolver.resolveHorsesScene()
        viewController.coordinator = self
        return viewController
    }
    
    func select(with horse: Horse) {
        let coordinator = DetailCoordinator(horse: horse, navController: navController! ,resolver: resolver)
        let viewController = coordinator.begin()
        navController?.pushViewController(viewController, animated: true)
    }
    
    func add(){
        let coordinator = AddHorseCoordinator(navController: navController!, resolver: resolver)
        let viewController = coordinator.begin()
        navController?.pushViewController(viewController, animated: true)
    }
}
