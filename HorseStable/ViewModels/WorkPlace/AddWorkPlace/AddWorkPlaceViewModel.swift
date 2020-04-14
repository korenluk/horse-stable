//
//  AddWorkPlaceViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 11/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import Foundation

class AddWorkPlaceViewModel: AddWorkPlaceViewModeling {
    weak var delegate: AddWorkPlaceViewModelDelegate?
    
    private var isFetching: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isFetching)
        }
    }

    private let workPlaceService: WorkPlaceService
    
    init(workPlaceService: WorkPlaceService) {
        self.workPlaceService = workPlaceService
    }
    
    func addWorkPlace(name: String, capacity: Int) {
        guard !isFetching else {
            return
        }
        isFetching = true
        let id = UserDefaults.standard.integer(forKey: "stableID")
        workPlaceService.addWorkPlace(name: name, capacity: capacity, stableID: id) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(_):
                self.delegate?.didAdd()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}
