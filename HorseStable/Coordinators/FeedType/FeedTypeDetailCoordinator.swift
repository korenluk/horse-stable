//
//  FeedTypeDetailCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 05/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

protocol FeedTypeDetailCoordinating: Coordinating {

}

class FeedTypeDetailCoordinator: FeedTypeDetailCoordinating {
    private let resolver: DependencyResolving
    private let feedType: FeedType
    private weak var navController: UINavigationController?
    
    init(feedType: FeedType, navController: UINavigationController ,resolver: DependencyResolving) {
        self.feedType = feedType
        self.resolver = resolver
        self.navController = navController
    }
    
    deinit {
        print("FEEDTYPE DETAIL \(feedType.id) DEINIT")
    }
    
    func begin() -> UIViewController {
        var viewController = resolver.resolveFeedTypeDetailScene(feedType: feedType)
        viewController.coordinator = self
        return viewController
    }
}
