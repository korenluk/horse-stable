//
//  AddWorkPlaceViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 11/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import Foundation

protocol AddWorkPlaceViewModelDelegate: class {
    func didUpdate(isBusy: Bool)
    func didAdd()
    func didFail(with error: Error)
}

protocol AddWorkPlaceViewModeling: class {
    var delegate: AddWorkPlaceViewModelDelegate? { get set }
    
    func addWorkPlace(name: String, capacity: Int)
}
