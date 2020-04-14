//
//  FeedCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 15/03/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

protocol FeedCoordinating {
    func select(with feed: Feed)
    func add()
}

class FeedCoordinator: FeedCoordinating {
    private let resolver: DependencyResolving
    private weak var navController: UINavigationController?
    private let feedType: FeedType
    
    init(feedType: FeedType, navController: UINavigationController, resolver: DependencyResolving) {
        self.feedType = feedType
        self.navController = navController
        self.resolver = resolver
    }
    
    deinit {
        print("FEED DEINIT")
    }
    
    func begin() -> UIViewController {
        var viewController = resolver.resolveFeedScene(with: feedType)
        viewController.coordinator = self
        return viewController
    }
    
    func select(with feed: Feed) {
//        let coordinator = FeedDetailCoordinator(with: feed, navController: navController! ,resolver: resolver)
//        let viewController = coordinator.begin()
//        navController?.pushViewController(viewController, animated: true)
    }

    func add(){
        let coordinator = AddFeedCoordinator(feedType: feedType, navController: navController!, resolver: resolver)
        let viewController = coordinator.begin()
        navController?.pushViewController(viewController, animated: true)
    }
}
