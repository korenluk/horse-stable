//
//  WorkPlacesViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 11/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

class WorkPlacesViewModel: WorkPlacesViewModeling {
        
    weak var delegate: WorkPlacesViewModelDelegate?
    
    private var isFetching: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isFetching)
        }
    }
    private var workPlaces = [WorkPlace]()
    private let workPlaceService: WorkPlaceService
    private let stableService: StableService
    
    init(workPlaceService: WorkPlaceService, stableService: StableService) {
        self.workPlaceService = workPlaceService
        self.stableService = stableService
    }
    
    func updateWorkPlaces() {
        fetchWorkPlaces()
    }
    
    func numberOfWorkPlaces() -> Int {
        return workPlaces.count
    }
    
    func workPlace(at index: Int) -> WorkPlace {
        return workPlaces[index]
    }
    
    func delete(identifier: Int) {
        deleteWorkPlace(identifier: identifier)
    }
}

private extension WorkPlacesViewModel {
    func fetchWorkPlaces() {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        let id = UserDefaults.standard.integer(forKey: "stableID")
        stableService.stableWorkPlaces(identifier: id) { [weak self] result in
            guard let self = self else {
                return
            }
            self.isFetching = false
            
            switch result {
            case let .success(workPlace):
                self.workPlaces = workPlace
                self.workPlaces.sort()
                self.delegate?.didUpdateWorkPlaces()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
    
    func deleteWorkPlace(identifier: Int) {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        workPlaceService.deleteWorkPlace(identifier: identifier) {[weak self] result in
            guard let self = self else {
                return
            }
            self.isFetching = false
            
            switch result {
            case .success(_):
                self.delegate?.didDeleteWorkPlace()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}
