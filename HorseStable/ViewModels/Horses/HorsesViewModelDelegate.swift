//
//  HorsesViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 29/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

protocol HorsesViewModelDelegate: class {
    func didUpdate(isBusy: Bool)
    func didUpdateHorses()
    func didDeleteHorse()
    func didFail(with error: Error)
}

protocol HorsesViewModeling: class {
    var delegate: HorsesViewModelDelegate? { get set }
    
    func updateHorses()
    func numberOfHorses() -> Int
    func horse(at index: Int) -> Horse
    func delete(identifier: Int)
}
