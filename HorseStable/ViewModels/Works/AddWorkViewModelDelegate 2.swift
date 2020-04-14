//
//  AddWorkViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 30/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

protocol AddWorkViewModelDelegate: class {
    func didUpdate(isBusy: Bool)
    func didFetchHorses()
    func didAdd()
    func didFail(with error: Error)
}

protocol AddWorkViewModeling: class {
    var delegate: AddWorkViewModelDelegate? { get set }
    var horses: [Horse] { get }
    var horseID: Int? {get set}
    var date: Date {get set}
    func fetchHorses()
    func addWork(name: String, horseID: String, date: String)
}
