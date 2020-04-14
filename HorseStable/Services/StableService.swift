//
//  StableService.swift
//  HorseStable
//
//  Created by Lukas Korinek on 20/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

class StableService {
    let apiManager: APIManaging
    
    init(apiManager: APIManaging) {
        self.apiManager = apiManager
    }
    
    func fetchStables(completion: @escaping (Result<[Stable], Error>) -> Void) {
        apiManager.request(request: StableRouter.stables, completion: completion)
    }
    
    func addStable(name: String, capacity: Int, userID: String, completion: @escaping (Result<Stable,Error>) -> Void) {
        apiManager.request(request: StableRouter.createStable(name: name, capacity: capacity, userID: userID), completion: completion)
    }
    
    func fetchStable(identifier: Int, completion: @escaping (Result<Stable,Error>) -> Void) {
        apiManager.request(request: StableRouter.stable(identifier: identifier), completion: completion)
    }
    
    func patchStable(identifier: Int, name: String, capacity: Int, completion: @escaping (Result<Stable,Error>) -> Void) {
        apiManager.request(request: StableRouter.updateStable(identifier: identifier, name: name, capacity: capacity), completion: completion)
    }
    
    func deleteStable(identifier: Int, completion: @escaping (Result<Stable,Error>) -> Void) {
        apiManager.request(request: StableRouter.deleteStable(identifier: identifier), completion: completion)
    }
    
    func stableHorses(identifier: Int, completion: @escaping (Result<[Horse],Error>) -> Void) {
        apiManager.request(request: StableRouter.stableHorses(identifier: identifier), completion: completion)
    }
    
    func stableWorks(identifier: Int, completion: @escaping (Result<[Work],Error>) -> Void) {
        apiManager.request(request: StableRouter.stableWorks(identifier: identifier), completion: completion)
    }
    
    func stableFeedTypes(identifier: Int, completion: @escaping (Result<[FeedType],Error>) -> Void) {
        apiManager.request(request: StableRouter.stableFeedTypes(identifier: identifier), completion: completion)
    }
    
    func stableWorkPlaces(identifier: Int, completion: @escaping (Result<[WorkPlace],Error>) -> Void) {
        apiManager.request(request: StableRouter.stableWorkPlaces(identifier: identifier), completion: completion)
    }
}
