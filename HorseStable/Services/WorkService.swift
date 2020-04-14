//
//  WorkService.swift
//  HorseStable
//
//  Created by Lukas Korinek on 23/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

class WorksService {
    let apiManager: APIManaging
    
    init(apiManager: APIManaging) {
        self.apiManager = apiManager
    }
    
    func fetchWorks(completion: @escaping (Result<[Work], Error>) -> Void) {
        apiManager.request(request: WorkRouter.works, completion: completion)
    }
    
    func addWork(name: String, horseID: String, date: String, stableID: String, completion: @escaping (Result<Work,Error>) -> Void) {
        apiManager.request(request: WorkRouter.createWork(name: name, horseID: horseID, date: date, stableID: stableID), completion: completion)
    }
    
    func fetchWork(identifier: Int, completion: @escaping (Result<Work,Error>) -> Void) {
        apiManager.request(request: WorkRouter.work(identifier: identifier), completion: completion)
    }
    
    func patchWork(identifier: Int, name: String, horseID: String, date: String, stableID: String, completion: @escaping (Result<Work,Error>) -> Void) {
        apiManager.request(request: WorkRouter.updateWork(identifier: identifier, name: name, horseID: horseID, date: date, stableID: stableID), completion: completion)
    }
    
    func deleteWork(identifier: Int, completion: @escaping (Result<Work,Error>) -> Void) {
        apiManager.request(request: WorkRouter.deleteWork(identifier: identifier), completion: completion)
    }
    
    func getHorse(identifier: Int, completion: @escaping (Result<Horse,Error>) -> Void) {
        apiManager.request(request: WorkRouter.horse(identifier: identifier), completion: completion)
    }
}
