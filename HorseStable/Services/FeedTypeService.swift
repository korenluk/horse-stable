//
//  FeedTypeService.swift
//  HorseStable
//
//  Created by Lukas Korinek on 04/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import Foundation

class FeedTypeService {
    let apiManager: APIManaging
    
    init(apiManager: APIManaging) {
        self.apiManager = apiManager
    }
    
    func fetchFeedTypes(completion: @escaping (Result<[FeedType], Error>) -> Void) {
        apiManager.request(request: FeedTypeRouter.feedTypes, completion: completion)
    }
    
    func fetchFeedType(identifier: Int, completion: @escaping (Result<FeedType,Error>) -> Void) {
        apiManager.request(request: FeedTypeRouter.feedType(identifier: identifier), completion: completion)
    }
    
    func addFeedType(name: String, capacity: Int?, actualCapacity: Int?, stableID: Int, completion: @escaping (Result<FeedType,Error>) -> Void) {
        if let capacity = capacity, let actualCapacity = actualCapacity {
            apiManager.request(request: FeedTypeRouter.createFeedTypeAll(name: name, capacity: capacity,actualCapacity: actualCapacity, stableID: stableID), completion: completion)
        } else {
            apiManager.request(request: FeedTypeRouter.createFeedType(name: name, stableID: stableID), completion: completion)
        }
    }
    
    func patchFeedType(identifier: Int, name: String, capacity: Int, actualCapacity: Int, completion: @escaping (Result<FeedType,Error>) -> Void) {
        apiManager.request(request: FeedTypeRouter.updateFeedType(identifier: identifier, name: name, capacity: capacity, actualCapacity: actualCapacity), completion: completion)
    }
    
    func deleteFeedType(identifier: Int, completion: @escaping (Result<FeedType,Error>) -> Void) {
        apiManager.request(request: FeedTypeRouter.deleteFeedType(identifier: identifier), completion: completion)
    }
    
    func feedTypesFeed(identifier: Int, completion: @escaping (Result<[Feed],Error>) -> Void) {
        apiManager.request(request: FeedTypeRouter.feedTypeFeeds(identifier: identifier), completion: completion)
    }
}
