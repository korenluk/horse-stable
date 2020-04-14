//
//  DefaultDependencyContainer.swift
//  HorseStable
//
//  Created by Lukas Korinek on 28/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

class DefaultDependencyContainer: DependencyResolving {
    // MARK: - Managers
    func resolveAPIManager() -> APIManaging {
        return APIManager()
    }

    func resolveAuthenticatedAPIManager() -> APIManaging {
        return APIManager(requestAdapter: resolveAuthenticatedRequestAdapter())
    }
}
