//
//  AddFeedTypeViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 04/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import Foundation

protocol AddFeedTypeViewModelDelegate: class {
    func didUpdate(isBusy: Bool)
    func didAdd()
    func didFail(with error: Error)
}

protocol AddFeedTypeViewModeling: class {
    var delegate: AddFeedTypeViewModelDelegate? { get set }
    
    func addFeedType(name: String, capacity: Int?, actualCapacity: Int?)
}
