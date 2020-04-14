//
//  AddFeedCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 05/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

protocol AddFeedCoordinating: Coordinating {
    func done()
}

class AddFeedCoordinator: AddFeedCoordinating {
    private let feedType: FeedType
    private let resolver: DependencyResolving
    private weak var navController: UINavigationController?
    
    init(feedType: FeedType, navController: UINavigationController, resolver: DependencyResolving) {
        self.feedType = feedType
        self.navController = navController
        self.resolver = resolver
    }
    
    deinit {
        print("ADD FEED DEINIT")
    }
    
    func begin() -> UIViewController{
        var viewController = resolver.resolveAddFeedScene(feedType: feedType)
        viewController.coordinator = self
        return viewController
    }
    
    func done() {
        navController?.popViewController(animated: true)
    }
}
