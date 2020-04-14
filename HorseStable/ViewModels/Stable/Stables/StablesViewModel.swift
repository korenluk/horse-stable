//
//  StablesViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 20/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

class StablesViewModel: StablesViewModeling {
    weak var delegate: StablesViewModelDelegate?
    
    private var isFetching: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isFetching)
        }
    }
    internal var stables = [Stable]()
    private let authService: AuthService
    
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func updateStables() {
        fetchStables()
    }
    
    func numberOfStables() -> Int {
        return stables.count
    }
    
    func stable(at index: Int) -> Stable {
        return stables[index]
    }
}

private extension StablesViewModel {
    func fetchStables() {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        guard let userID = UserDefaults.standard.string(forKey: "userID") else {
            return
        }
        
        authService.userStables(identifier: userID) { [weak self] result in
            guard let self = self else {
                return
            }
            self.isFetching = false
            
            switch result {
            case let .success(stables):
                self.stables = stables
                self.stables.sort()
                if stables.count == 1 {
                    UserDefaults.standard.set(stables.first?.id, forKey: "stableID")
                    UserDefaults.standard.set(stables.first?.capacity, forKey: "capacity")
                }
                self.delegate?.didUpdateStables()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}
