//
//  WorkPlaceService.swift
//  HorseStable
//
//  Created by Lukas Korinek on 10/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import Foundation

class WorkPlaceService {
    let apiManager: APIManaging
    
    init(apiManager: APIManaging) {
        self.apiManager = apiManager
    }
    
    func fetchWorkPlaces(completion: @escaping (Result<[WorkPlace], Error>) -> Void) {
        apiManager.request(request: WorkPlaceRouter.workPlaces, completion: completion)
    }
    
    func fetchWorkPlace(identifier: Int, completion: @escaping (Result<WorkPlace,Error>) -> Void) {
        apiManager.request(request: WorkPlaceRouter.workPlace(identifier: identifier), completion: completion)
    }
    
    func addWorkPlace(name: String, capacity: Int, stableID: Int, completion: @escaping (Result<WorkPlace,Error>) -> Void) {
        apiManager.request(request: WorkPlaceRouter.createWorkPlace(name: name, capacity: capacity, stableID: stableID), completion: completion)
    }
    
    func patchWorkPlace(identifier: Int, name: String, capacity: Int, stableID: Int, completion: @escaping (Result<WorkPlace,Error>) -> Void) {
        apiManager.request(request: WorkPlaceRouter.updateWorkPlace(identifier: identifier, name: name, capacity: capacity, stableID: stableID), completion: completion)
    }
    
    func deleteWorkPlace(identifier: Int, completion: @escaping (Result<WorkPlace,Error>) -> Void) {
        apiManager.request(request: WorkPlaceRouter.deleteWorkPlace(identifier: identifier), completion: completion)
    }
    
    func WorkPlacesWorks(identifier: Int, completion: @escaping (Result<[Feed],Error>) -> Void) {
        apiManager.request(request: WorkPlaceRouter.workPlaceWorks(identifier: identifier), completion: completion)
    }
}
