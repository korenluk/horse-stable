//
//  WorkPlaceDetailViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 11/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

class WorkPlaceDetailViewModel: WorkPlaceDetailViewModeling {
    weak var delegate: WorkPlaceDetailViewModelDelegate?
    
    private var isFetching: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isFetching)
        }
    }
    
    private(set) var workPlace: WorkPlace
    private let workPlaceService: WorkPlaceService
    
    init(workPlace: WorkPlace, workPlaceService: WorkPlaceService) {
        self.workPlace = workPlace
        self.workPlaceService = workPlaceService
    }
}

extension WorkPlaceDetailViewModel {
    
    func fetchWorkPlace() {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        workPlaceService.fetchWorkPlace(identifier: workPlace.id) { [weak self] result in
            guard let self = self else {
                return
            }
            self.isFetching = false
            
            switch result {
            case let .success(workPlace):
                self.workPlace = workPlace
                self.delegate?.didFetchWorkPlace()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
    
    func patchWorkPlace(name: String, capacity: Int) {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        let id = UserDefaults.standard.integer(forKey: "stableID")
        workPlaceService.patchWorkPlace(identifier: workPlace.id, name: name, capacity: capacity, stableID: id) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(workPlace):
                self.workPlace.name = workPlace.name
                self.delegate?.didUpdateWorkPlace()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}
