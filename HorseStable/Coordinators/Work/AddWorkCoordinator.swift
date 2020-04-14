//
//  AddWorkCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 30/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol AddWorkCoordinating: Coordinating {
    func done()
}

class AddWorkCoordinator: AddWorkCoordinating {
    private let resolver: DependencyResolving
    private weak var navController: UINavigationController?
    private var horseID: Int?
    private var date: Date
    
    init(date: Date, horseID: Int?,navController: UINavigationController, resolver: DependencyResolving) {
        self.navController = navController
        self.resolver = resolver
        self.horseID = horseID
        self.date = date
    }
    
    deinit {
        print("ADD WORK DEINIT")
    }
    
    func begin() -> UIViewController{
        var viewController = resolver.resolveAddWorkScene(date: date, horseID: horseID)
        viewController.coordinator = self
        return viewController
    }
    
    func done() {
        navController?.popViewController(animated: true)
    }
}
