//
//  DetailViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 31/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

protocol DetailViewModelDelegate: class {

}

protocol DetailViewModeling: class {
    var horse: Horse {get set}
    var delegate: DetailViewModelDelegate? { get set }

}
