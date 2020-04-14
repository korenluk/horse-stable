//
//  StablesCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 20/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol StablesCoordinating {
    func add()
}

class StablesCoordinator: StablesCoordinating {
    private let resolver: DependencyResolving
    private weak var navController: UINavigationController?
    
    init(navController: UINavigationController, resolver: DependencyResolving) {
        self.navController = navController
        self.resolver = resolver
    }
    
    deinit {
        print("STABLES DEINIT")
    }
    
    func begin() -> StablesViewControlling & UIViewController {
        var viewController = resolver.resolveStablesScene()
        viewController.coordinator = self
        return viewController
    }
    
    func add(){
        let coordinator = AddStableCoordinator(navController: navController!, resolver: resolver)
        let viewController = coordinator.begin()
        //navController?.pushViewController(viewController, animated: true)
        viewController.modalPresentationStyle = .fullScreen
        navController?.present(viewController, animated: true, completion: nil)
    }
}
