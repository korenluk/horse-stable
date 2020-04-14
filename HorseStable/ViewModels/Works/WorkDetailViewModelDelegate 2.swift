//
//  WorkDetailViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 28/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

protocol WorkDetailViewModelDelegate: class {
    func didUpdate(isBusy: Bool)
    func didFetchWork()
    func didFetchHorses()
    func didUpdateWork()
    func didFail(with error: Error)
}

protocol WorkDetailViewModeling: class {
    var delegate: WorkDetailViewModelDelegate? { get set }
    var work: Work { get }
    var horses: [Horse] { get }
    func fetchWork()
    func fetchHorses()
    func patchWork(name: String, horseID: String, date: String)
}
