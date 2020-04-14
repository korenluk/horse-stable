//
//  AddHorseViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 29/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

protocol AddHorseViewModelDelegate: class {
    func didUpdate(isBusy: Bool)
    func didAdd()
    func didFail(with error: Error)
}

protocol AddHorseViewModeling: class {
    var delegate: AddHorseViewModelDelegate? { get set }
    
    func addHorse(name: String, birth: String, gender: String, color: String, breed: String)
}
