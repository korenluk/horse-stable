//
//  FeedTypeCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 04/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

protocol FeedTypesCoordinating {
    func select(with feedType: FeedType)
    func selectFeed(with feedType: FeedType)
    func add()
}

class FeedTypesCoordinator: FeedTypesCoordinating {
    private let resolver: DependencyResolving
    private weak var navController: UINavigationController?
    
    init(navController: UINavigationController, resolver: DependencyResolving) {
        self.navController = navController
        self.resolver = resolver
    }
    
    deinit {
        print("FEEDTYPE DEINIT")
    }
    
    func begin() -> UIViewController {
        var viewController = resolver.resolveFeedTypesScene()
        viewController.coordinator = self
        return viewController
    }
    
    func selectFeed(with feedType: FeedType) {
        let coordinator = FeedCoordinator(feedType: feedType, navController: navController! ,resolver: resolver)
        let viewController = coordinator.begin()
        navController?.pushViewController(viewController, animated: true)
    }
    
    func select(with feedType: FeedType) {
        let coordinator = FeedTypeDetailCoordinator(feedType: feedType, navController: navController! ,resolver: resolver)
        let viewController = coordinator.begin()
        navController?.pushViewController(viewController, animated: true)
    }

    func add(){
        let coordinator = AddFeedTypeCoordinator(navController: navController!, resolver: resolver)
        let viewController = coordinator.begin()
        navController?.pushViewController(viewController, animated: true)
    }
}
