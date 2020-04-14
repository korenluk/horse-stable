//
//  DetailCoorinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 31/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol DetailCoordinating: Coordinating {
    func done()
    func horseDetail()
    func workDetail()
    func medicalDetail()
}

class DetailCoordinator: DetailCoordinating {
    private let resolver: DependencyResolving
    private weak var navController: UINavigationController?
    var horse: Horse
    
    init(horse: Horse, navController: UINavigationController, resolver: DependencyResolving) {
        self.navController = navController
        self.resolver = resolver
        self.horse = horse
    }
    
    deinit {
        print("DETAIL DEINIT")
    }
    
    func begin() -> UIViewController{
        var viewController = resolver.resolveDetailScene(horse: horse)
        viewController.coordinator = self
        return viewController
    }
    
    func done() {
        navController?.popViewController(animated: true)
    }
    
    func horseDetail() {
        let coordinator = HorseDetailCoordinator(horse: horse, navController: navController! ,resolver: resolver)
        let viewController = coordinator.begin()
        navController?.pushViewController(viewController, animated: true)
    }
    
    func workDetail() {
        let coordinator = HorseWorksCoordinator(horse: horse, navController: navController! ,resolver: resolver)
        let viewController = coordinator.begin()
        navController?.pushViewController(viewController, animated: true)
    }
    
    func medicalDetail(){
        let coordinator = MedicalCoordinator(horse: horse, navController: navController! ,resolver: resolver)
        let viewController = coordinator.begin()
        navController?.pushViewController(viewController, animated: true)
    }
}
