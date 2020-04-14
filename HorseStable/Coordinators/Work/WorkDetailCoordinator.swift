//
//  WorkDetailCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 28/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol WorkDetailCoordinating: Coordinating {

}

class WorkDetailCoordinator: WorkDetailCoordinating {
    private let resolver: DependencyResolving
    private let work: Work
    private weak var navController: UINavigationController?
    
    init(with work: Work, navController: UINavigationController ,resolver: DependencyResolving) {
        self.work = work
        self.resolver = resolver
        self.navController = navController
    }
    
    deinit {
        print("WORK DETAIL \(work.id) DEINIT")
    }
    
    func begin() -> UIViewController {
        var viewController = resolver.resolveWorkDetailScene(work: work)
        viewController.coordinator = self
        return viewController
    }
}
