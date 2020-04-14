//
//  StableViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 20/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

protocol AddStableViewModelDelegate: class {
    func didUpdate(isBusy: Bool)
    func didAdd()
    func didFail(with error: Error)
}

protocol AddStableViewModeling: class {
    var delegate: AddStableViewModelDelegate? { get set }
    
    func addStable(name: String, capacity: Int)
}
