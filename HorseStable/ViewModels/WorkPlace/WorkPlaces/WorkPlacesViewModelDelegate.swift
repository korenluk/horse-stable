//
//  WorkPlacesViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 11/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import Foundation

protocol WorkPlacesViewModelDelegate: class {
    func didUpdate(isBusy: Bool)
    func didUpdateWorkPlaces()
    func didDeleteWorkPlace()
    func didFail(with error: Error)
}

protocol WorkPlacesViewModeling: class {
    var delegate: WorkPlacesViewModelDelegate? { get set }
    
    func updateWorkPlaces()
    func numberOfWorkPlaces() -> Int
    func workPlace(at index: Int) -> WorkPlace
    func delete(identifier: Int)
}
