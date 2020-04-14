//
//  HorseDetailViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 29/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

class HorseDetailViewModel: HorseDetailViewModeling {
    weak var delegate: HorseDetailViewModelDelegate?
    
    private var isFetching: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isFetching)
        }
    }
    
    private(set) var horse: Horse
    private let horsesService: HorsesService
    
    init(horse: Horse, horsesService: HorsesService) {
        self.horse = horse
        self.horsesService = horsesService
    }
}

extension HorseDetailViewModel {
    
    func fetchHorse() {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        horsesService.fetchHorse(identifier: horse.id) { [weak self] result in
            guard let self = self else {
                return
            }
            self.isFetching = false
            
            switch result {
            case let .success(horse):
                self.horse = horse
                self.delegate?.didFetchHorse()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
    
    func patchHorse(name: String, birth: String) {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        horsesService.patchHorse(identifier: horse.id, name: name, birth: birth) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(horse):
                self.horse.name = horse.name
                self.delegate?.didUpdateHorse()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}
