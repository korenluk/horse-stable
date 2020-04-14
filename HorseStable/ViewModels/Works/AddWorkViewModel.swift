//
//  AddWorkViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 30/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

class AddWorkViewModel: AddWorkViewModeling {
    weak var delegate: AddWorkViewModelDelegate?
    
    private var isFetching: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isFetching)
        }
    }
    internal var date: Date
    internal var horseID: Int?
    internal var horses = [Horse]()
    private let worksService: WorksService
    private let stableService: StableService
    
    init(date: Date, horseID: Int?, worksService: WorksService, stableService: StableService) {
        self.worksService = worksService
        self.stableService = stableService
        self.horseID = horseID
        self.date = date
    }
    
    func addWork(name: String, horseID: String, date: String) {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        guard let id = UserDefaults.standard.string(forKey: "stableID") else {
            return
        }
        worksService.addWork(name: name, horseID: horseID, date: date, stableID: id) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(work):
                print(work.name)
                self.delegate?.didAdd()
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
}

