//
//  WorksViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 23/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

protocol WorksViewModelDelegate: class {
    func didUpdate(isBusy: Bool)
    func didUpdateWorks()
    func didDeleteWork()
    func didFail(with error: Error)
}

protocol WorksViewModeling: class {
    var delegate: WorksViewModelDelegate? { get set }
    
    func updateWorks()
    func numberOfWorks(date: Date) -> Int
    func work(at index: Int) -> Work
    func delete(identifier: Int)
}
