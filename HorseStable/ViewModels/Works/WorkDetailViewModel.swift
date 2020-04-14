//
//  WorkDetailViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 28/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

class WorkDetailViewModel: WorkDetailViewModeling {
    weak var delegate: WorkDetailViewModelDelegate?
    
    private var isFetching: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isFetching)
        }
    }
    
    private(set) var work: Work
    private(set) var horses = [Horse]()
    private let worksService: WorksService
    private let stableService: StableService
    
    init(work: Work, worksService: WorksService, stableService: StableService) {
        self.work = work
        self.worksService = worksService
        self.stableService = stableService
    }
}

extension WorkDetailViewModel {
    
    func fetchWork() {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        worksService.fetchWork(identifier: work.id) { [weak self] result in
            guard let self = self else {
                return
            }
            self.isFetching = false
            
            switch result {
            case let .success(work):
                self.work = work
                self.delegate?.didFetchWork()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
    
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
                self.delegate?.didFetchHorses()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
    
    func patchWork(name: String, horseID: String, date: String) {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        guard let id = UserDefaults.standard.string(forKey: "stableID") else {
            return
        }
        worksService.patchWork(identifier: work.id, name: name, horseID: horseID, date: date, stableID: id) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(_):
                self.delegate?.didUpdateWork()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}
