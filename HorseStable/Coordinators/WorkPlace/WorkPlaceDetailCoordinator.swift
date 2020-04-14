//
//  WorkPlaceDetailCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 10/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

protocol WorkPlaceDetailCoordinating: Coordinating {

}

class WorkPlaceDetailCoordinator: WorkPlaceDetailCoordinating {
    private let resolver: DependencyResolving
    private let workPlace: WorkPlace
    private weak var navController: UINavigationController?
    
    init(workPlace: WorkPlace, navController: UINavigationController ,resolver: DependencyResolving) {
        self.workPlace = workPlace
        self.resolver = resolver
        self.navController = navController
    }
    
    deinit {
        print("WorkPlace DETAIL \(workPlace.id) DEINIT")
    }
    
    func begin() -> UIViewController {
        var viewController = resolver.resolveWorkPlaceDetailScene(workPlace: workPlace)
        viewController.coordinator = self
        return viewController
    }
}
