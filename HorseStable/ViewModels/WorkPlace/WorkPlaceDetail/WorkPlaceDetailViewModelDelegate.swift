//
//  WorkPlaceDetailViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 11/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

protocol WorkPlaceDetailViewModelDelegate: class {
    func didUpdate(isBusy: Bool)
    func didUpdateWorkPlace()
    func didFetchWorkPlace()
    func didFail(with error: Error)
}

protocol WorkPlaceDetailViewModeling: class {
    var delegate: WorkPlaceDetailViewModelDelegate? { get set }
    var workPlace: WorkPlace { get }
    func fetchWorkPlace()
    func patchWorkPlace(name: String, capacity: Int)
}
