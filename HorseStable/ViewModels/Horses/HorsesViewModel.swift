//
//  HorsesViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 29/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

class HorsesViewModel: HorsesViewModeling {
    
    weak var delegate: HorsesViewModelDelegate?
    
    private var isFetching: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isFetching)
        }
    }
    private var horses = [Horse]()
    private let horsesService: HorsesService
    private let stableService: StableService
    
    init(horsesService: HorsesService, stableService: StableService) {
        self.horsesService = horsesService
        self.stableService = stableService
    }
    
    func updateHorses() {
        fetchHorses()
    }
    
    func numberOfHorses() -> Int {
        return horses.count
    }
    
    func horse(at index: Int) -> Horse {
        return horses[index]
    }
    
    func delete(identifier: Int) {
        deleteHorse(identifier: identifier)
    }
}

private extension HorsesViewModel {
    func fetchHorses() {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        let id = UserDefaults.standard.integer(forKey: "stableID")
        stableService.stableHorses(identifier: id) { [weak self] result in
            guard let self = self else {
                return
            }
            self.isFetching = false
            
            switch result {
            case let .success(horses):
                self.horses = horses
                self.horses.sort()
                self.delegate?.didUpdateHorses()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
    
    func deleteHorse(identifier: Int) {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        horsesService.deleteHorse(identifier: identifier) {[weak self] result in
            guard let self = self else {
                return
            }
            self.isFetching = false
            
            switch result {
            case .success(_):
                self.delegate?.didDeleteHorse()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}
