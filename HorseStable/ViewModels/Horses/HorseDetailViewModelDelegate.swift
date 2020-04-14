//
//  HorseViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 29/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol HorseDetailViewModelDelegate: class {
    func didUpdate(isBusy: Bool)
    func didUpdateHorse()
    func didFetchHorse()
    func didFail(with error: Error)
}

protocol HorseDetailViewModeling: class {
    var delegate: HorseDetailViewModelDelegate? { get set }
    var horse: Horse { get }
    func fetchHorse()
    func patchHorse(name: String, birth: String)
}
