//
//  MedicalViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 26/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

class MedicalViewModel: MedicalViewModeling {
    weak var delegate: MedicalViewModelDelegate?
    
    private var isFetching: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isFetching)
        }
    }
    internal var medical = [Medical]()
    private let horseService: HorsesService
    private let horse: Horse
    
    
    init(horse: Horse, horseService: HorsesService) {
        self.horseService = horseService
        self.horse = horse
    }
    
    func updateMedical() {
        fetchMedical()
    }
    
    func numberOfMedical() -> Int {
        return medical.count
    }
    
    func medical(at index: Int) -> Medical {
        return medical[index]
    }
}

private extension MedicalViewModel {
    func fetchMedical() {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        
        
        horseService.horseMedical(identifier: horse.id){ [weak self] result in
            guard let self = self else {
                return
            }
            self.isFetching = false
            
            switch result {
            case let .success(medical):
                self.medical = medical
                self.medical.sort()
                self.delegate?.didUpdateMedical()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}
