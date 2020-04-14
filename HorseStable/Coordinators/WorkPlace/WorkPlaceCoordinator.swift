//
//  WorkPlaceCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 10/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

protocol WorkPlacesCoordinating {
    func select(with workPlace: WorkPlace)
    func selectWorks(with workPlace: WorkPlace)
    func add()
}

class WorkPlacesCoordinator: WorkPlacesCoordinating {
    private let resolver: DependencyResolving
    private weak var navController: UINavigationController?
    
    init(navController: UINavigationController, resolver: DependencyResolving) {
        self.navController = navController
        self.resolver = resolver
    }
    
    deinit {
        print("WORKPLACE DEINIT")
    }
    
    func begin() -> UIViewController {
        var viewController = resolver.resolveWorkPlacesScene()
        viewController.coordinator = self
        return viewController
    }
    
    func selectWorks(with workPlace: WorkPlace) {
        let coordinator = WorksCoordinator(navController: navController! ,resolver: resolver)
        let viewController = coordinator.begin()
        navController?.pushViewController(viewController, animated: true)
    }
    
    func select(with workPlace: WorkPlace) {
        let coordinator = WorkPlaceDetailCoordinator(workPlace: workPlace, navController: navController! ,resolver: resolver)
        let viewController = coordinator.begin()
        navController?.pushViewController(viewController, animated: true)
    }

    func add(){
        let coordinator = AddWorkPlaceCoordinator(navController: navController!, resolver: resolver)
        let viewController = coordinator.begin()
        navController?.pushViewController(viewController, animated: true)
    }
}
