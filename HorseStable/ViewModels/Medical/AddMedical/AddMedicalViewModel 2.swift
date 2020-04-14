//
//  AddMedicalViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 26/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

class AddMedicalViewModel: AddMedicalViewModeling {
    weak var delegate: AddMedicalViewModelDelegate?
    
    private var isFetching: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isFetching)
        }
    }

    private let medicalService: MedicalService
    private let horse: Horse
    
    init(horse: Horse, medicalService: MedicalService) {
        self.medicalService = medicalService
        self.horse = horse
    }
    
    func addMedical(name: String, date: String) {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        medicalService.addMedical(name: name, date: date, horseID: horse.id) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(Medical):
                print(Medical.name)
                self.delegate?.didAdd()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}
