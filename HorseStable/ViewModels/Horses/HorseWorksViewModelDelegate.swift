//
//  HorseWorksViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 31/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

protocol HorseWorksViewModelDelegate: class {
    func didUpdate(isBusy: Bool)
    func didUpdateWorks()
    func didDeleteWork()
    func didFail(with error: Error)
}

protocol HorseWorksViewModeling: class {
    var delegate: HorseWorksViewModelDelegate? { get set }
    var horse: Horse { get set }
    
    func updateWorks()
    func numberOfWorks() -> Int
    func work(at index: Int) -> Work
    func delete(identifier: Int)
}
