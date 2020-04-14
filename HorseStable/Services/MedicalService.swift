//
//  MedicalService.swift
//  HorseStable
//
//  Created by Lukas Korinek on 26/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

class MedicalService {
    let apiManager: APIManaging
    
    init(apiManager: APIManaging) {
        self.apiManager = apiManager
    }
    
    func fetchMedical(completion: @escaping (Result<[Medical], Error>) -> Void) {
        apiManager.request(request: MedicalRouter.medicals, completion: completion)
    }
    
    func addMedical(name: String, date: String, horseID: Int, completion: @escaping (Result<Medical,Error>) -> Void) {
        apiManager.request(request: MedicalRouter.createMedical(name: name, date: date, horseID: horseID), completion: completion)
    }
    
    func fetchMedical(identifier: Int, completion: @escaping (Result<Medical,Error>) -> Void) {
        apiManager.request(request: MedicalRouter.medical(identifier: identifier), completion: completion)
    }
    
    func patchMedical(identifier: Int, name: String, date: String, completion: @escaping (Result<Medical,Error>) -> Void) {
        apiManager.request(request: MedicalRouter.updateMedical(identifier: identifier, name: name, date: date), completion: completion)
    }
    
    func deleteMedical(identifier: Int, completion: @escaping (Result<Medical,Error>) -> Void) {
        apiManager.request(request: MedicalRouter.deleteMedical(identifier: identifier), completion: completion)
    }
}
