//
//  FeedService.swift
//  HorseStable
//
//  Created by Lukas Korinek on 05/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import Foundation

class FeedService {
    let apiManager: APIManaging
    
    init(apiManager: APIManaging) {
        self.apiManager = apiManager
    }
    
    func fetchFeeds(completion: @escaping (Result<[Feed], Error>) -> Void) {
        apiManager.request(request: FeedRouter.feeds, completion: completion)
    }
    
    func addFeed(name: String, amount: Int, horseID: Int, feedTypeID: Int, completion: @escaping (Result<Feed,Error>) -> Void) {
        apiManager.request(request: FeedRouter.createFeed(name: name, amount: amount, horseID: horseID, feedTypeID: feedTypeID), completion: completion)
    }
    
    func fetchFeed(identifier: Int, completion: @escaping (Result<Feed,Error>) -> Void) {
        apiManager.request(request: FeedRouter.feed(identifier: identifier), completion: completion)
    }
    
    func patchFeed(identifier: Int, name: String, amount: Int, completion: @escaping (Result<Feed,Error>) -> Void) {
        apiManager.request(request: FeedRouter.updateFeed(identifier: identifier, name: name, amount: amount), completion: completion)
    }
    
    func deleteFeed(identifier: Int, completion: @escaping (Result<Feed,Error>) -> Void) {
        apiManager.request(request: FeedRouter.deleteFeed(identifier: identifier), completion: completion)
    }
}
