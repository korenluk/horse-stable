//
//  WorksCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 23/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol WorksCoordinating {
    func select(with work: Work)
    func add(date: Date)
}

class WorksCoordinator: WorksCoordinating {
    private let resolver: DependencyResolving
    private weak var navController: UINavigationController?
    
    init(navController: UINavigationController, resolver: DependencyResolving) {
        self.navController = navController
        self.resolver = resolver
    }
    
    deinit {
        print("WORKS DEINIT")
    }
    
    func begin() -> UIViewController {
        var viewController = resolver.resolveWorksScene()
        viewController.coordinator = self
        return viewController
    }
    
    func select(with work: Work) {
        let coordinator = WorkDetailCoordinator(with: work, navController: navController! ,resolver: resolver)
        let viewController = coordinator.begin()
        navController?.pushViewController(viewController, animated: true)
    }
    
    func add(date: Date){
        let coordinator = AddWorkCoordinator(date: date, horseID: 0, navController: navController!, resolver: resolver)
        let viewController = coordinator.begin()
        navController?.pushViewController(viewController, animated: true)
    }
}
