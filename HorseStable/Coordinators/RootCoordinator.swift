//
//  RootCoordinator.swift
//  HorseStable
//
//  Created by Lukas Korinek on 28/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

class RootCoordinator: Coordinating {
    private weak var window: UIWindow?
    private let resolver: DependencyResolving
    
    init(window: UIWindow, resolver: DependencyResolving) {
        self.window = window
        self.resolver = resolver
    }
    
    func begin() -> UIViewController {
        let keychainManager = resolver.resolveKeychainManager()
        //keychainManager.removeValue(forKey: .accessToken)
        print(keychainManager.value(forKey: .accessToken))
        if keychainManager.value(forKey: .accessToken) != nil {
            return createStableController()
        }
        return createLogInController()
    }
}

private extension RootCoordinator {
    func set(rootController: UIViewController) {
        window?.rootViewController = rootController
    }
    
    func setLogInScene() {
        let loginController = createLogInController()
        set(rootController: loginController)
    }

    func setMainScene() {
        let mainController = createMainController()
        set(rootController: mainController)
    }
    
    func setStableScene() {
        let stableController = createStableController()
        set(rootController: stableController)
    }
    
    func createStableController() -> UIViewController{
        let navController = BlankNavigationViewController()
        let coordinator = StablesCoordinator(navController: navController, resolver: resolver)
        var viewController = coordinator.begin()
        viewController.done = { [weak self] in
            self?.setMainScene()
        }
        navController.viewControllers = [viewController]
        return navController
    }
    
    func createMainController() -> UIViewController {
        let tabBarController = resolver.resolveMainTabBarController()
        tabBarController.viewControllers = [beginHorsesScene(),beginWorkScene(),beginFeedScene(),beginSettingsScene()]
        return tabBarController
    }
    
    func createLogInController() -> UIViewController {
        let navController = BlankNavigationViewController()
        let coordinator = LoginCoordinator(navController: navController, resolver: resolver)
        var viewController = coordinator.begin()
        viewController.logIn = { [weak self] in
            self?.setStableScene()
        }
        navController.viewControllers = [viewController]
        return navController
    }
    
    func beginHorsesScene() -> UIViewController {
        let navController = BlankNavigationViewController()
        let coordinator = HorsesCoordinator(navController: navController, resolver: resolver)
        let viewController = coordinator.begin()
        navController.viewControllers = [viewController]
        return navController
    }
    
    func beginWorkScene() -> UIViewController {
        let navController = BlankNavigationViewController()
        let coordinator = WorkPlacesCoordinator(navController: navController, resolver: resolver)
        let viewController = coordinator.begin()
        navController.viewControllers = [viewController]
        return navController
    }
    
    func beginFeedScene() -> UIViewController {
        let navController = BlankNavigationViewController()
        let coordinator = FeedTypesCoordinator(navController: navController, resolver: resolver)
        let viewController = coordinator.begin()
        navController.viewControllers = [viewController]
        return navController
    }
    
    func beginSettingsScene() -> UIViewController {
        let navController = BlankNavigationViewController()
        let coordinator = SettingsCoordinator(navController: navController, resolver: resolver) { [weak self] in
            self?.setLogInScene()
        }
        coordinator.changeStable = { [weak self] in
            self?.setStableScene()
        }
        let viewController = coordinator.begin()
        navController.viewControllers = [viewController]
        return navController
    }
}
