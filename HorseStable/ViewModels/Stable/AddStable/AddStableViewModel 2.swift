//
//  Stable.swift
//  HorseStable
//
//  Created by Lukas Korinek on 20/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

class AddStableViewModel: AddStableViewModeling {
    weak var delegate: AddStableViewModelDelegate?
    
    private var isFetching: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isFetching)
        }
    }

    private let stableService: StableService
    
    init(stableService: StableService) {
        self.stableService = stableService
    }
    
    func addStable(name: String, capacity: Int) {
        guard !isFetching else {
            return
        }
        
        guard let userID = UserDefaults.standard.string(forKey: "userID") else {
            return
        }
        isFetching = true
        stableService.addStable(name: name, capacity: capacity, userID: userID) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(stable):
                print(stable.name)
                self.delegate?.didAdd()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}
