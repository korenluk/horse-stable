//
//  AddMedicalViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 26/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

protocol AddMedicalViewModelDelegate: class {
    func didUpdate(isBusy: Bool)
    func didAdd()
    func didFail(with error: Error)
}

protocol AddMedicalViewModeling: class {
    var delegate: AddMedicalViewModelDelegate? { get set }
    
    func addMedical(name: String, date: String)
}
