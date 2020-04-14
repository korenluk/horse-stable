//
//  MedicalViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 26/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//


protocol MedicalViewModelDelegate: class {
    func didUpdate(isBusy: Bool)
    func didUpdateMedical()
    func didFail(with error: Error)
}

protocol MedicalViewModeling: class {
    var delegate: MedicalViewModelDelegate? { get set }
    
    func updateMedical()
    func numberOfMedical() -> Int
    func medical(at index: Int) -> Medical
}
