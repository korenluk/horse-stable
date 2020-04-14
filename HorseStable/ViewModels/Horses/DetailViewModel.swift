//
//  DetailViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 31/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

class DetailViewModel: DetailViewModeling {

    var horse: Horse
    
    weak var delegate: DetailViewModelDelegate?

    init(horse: Horse) {
        self.horse = horse
    }
}
