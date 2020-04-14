//
//  StablesViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 20/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

protocol StablesViewModelDelegate: class {
    func didUpdate(isBusy: Bool)
    func didUpdateStables()
    func didFail(with error: Error)
}

protocol StablesViewModeling: class {
    var delegate: StablesViewModelDelegate? { get set }
    
    func updateStables()
    func numberOfStables() -> Int
    func stable(at index: Int) -> Stable
}
