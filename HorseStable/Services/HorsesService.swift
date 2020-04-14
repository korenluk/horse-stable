//
//  HorsesService.swift
//  HorseStable
//
//  Created by Lukas Korinek on 29/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

class HorsesService {
    let apiManager: APIManaging
    
    init(apiManager: APIManaging) {
        self.apiManager = apiManager
    }
    
    func fetchHorses(completion: @escaping (Result<[Horse], Error>) -> Void) {
        apiManager.request(request: HorseRouter.horses, completion: completion)
    }
    
    func addHorse(name: String, birth: String, gender: String, color: String, breed: String, userID: String, stableID: String, completion: @escaping (Result<Horse,Error>) -> Void) {
        apiManager.request(request: HorseRouter.createHorse(name: name, birth: birth, gender: gender, color: color, breed: breed, userID: userID, stableID: stableID), completion: completion)
    }
    
    func fetchHorse(identifier: Int, completion: @escaping (Result<Horse,Error>) -> Void) {
        apiManager.request(request: HorseRouter.horse(identifier: identifier), completion: completion)
    }
    
    func patchHorse(identifier: Int, name: String, birth: String, completion: @escaping (Result<Horse,Error>) -> Void) {
        apiManager.request(request: HorseRouter.updateHorse(identifier: identifier, name: name, birth: birth), completion: completion)
    }
    
    func deleteHorse(identifier: Int, completion: @escaping (Result<Horse,Error>) -> Void) {
        apiManager.request(request: HorseRouter.deleteHorse(identifier: identifier), completion: completion)
    }
    
    func horseWorks(identifier: Int, completion: @escaping (Result<[Work],Error>) -> Void) {
        apiManager.request(request: HorseRouter.horseWorks(identifier: identifier), completion: completion)
    }
    
    func horseMedical(identifier: Int, completion: @escaping (Result<[Medical],Error>) -> Void) {
        apiManager.request(request: HorseRouter.horseMedical(identifier: identifier), completion: completion)
    }
}
