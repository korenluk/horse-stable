//
//  AddHorseViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 29/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

class AddHorseViewModel: AddHorseViewModeling {    
    weak var delegate: AddHorseViewModelDelegate?
    
    private var isFetching: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isFetching)
        }
    }
    
    private let horsesService: HorsesService
    
    init(horsesService: HorsesService) {
        self.horsesService = horsesService
    }
    
    func addHorse(name: String, birth: String, gender: String, color: String, breed: String) {
        guard !isFetching else {
            return
        }
        
        guard let userID = UserDefaults.standard.string(forKey: "userID") else {
            return
        }
        guard let stableID = UserDefaults.standard.string(forKey: "stableID") else {
            return
        }
        isFetching = true
        horsesService.addHorse(name: name, birth: birth, gender: gender, color: color, breed: breed, userID: userID, stableID: stableID) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(horse):
                print(horse.name)
                self.delegate?.didAdd()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}

