//
//  HorseWorksCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 31/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol HorseWorksCoordinating {
    func select(with work: Work)
    func add()
}

class HorseWorksCoordinator: HorseWorksCoordinating {
    private let resolver: DependencyResolving
    private weak var navController: UINavigationController?
    private let horse: Horse
    
    init(horse: Horse, navController: UINavigationController, resolver: DependencyResolving) {
        self.navController = navController
        self.resolver = resolver
        self.horse = horse
    }
    
    deinit {
        print("HORSE WORKS DEINIT")
    }
    
    func begin() -> UIViewController {
        var viewController = resolver.resolveHorseWorksScene(horse: horse)
        viewController.coordinator = self
        return viewController
    }
    
    func select(with work: Work) {
        let coordinator = WorkDetailCoordinator(with: work, navController: navController! ,resolver: resolver)
        let viewController = coordinator.begin()
        navController?.pushViewController(viewController, animated: true)
    }
    
    func add(){
        let coordinator = AddWorkCoordinator(date: Date(), horseID: horse.id,navController: navController!, resolver: resolver)
        let viewController = coordinator.begin()
        navController?.pushViewController(viewController, animated: true)
    }
}
