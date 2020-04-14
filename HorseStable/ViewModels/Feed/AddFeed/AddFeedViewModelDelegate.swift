//
//  AddFeedViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 05/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import Foundation

protocol AddFeedViewModelDelegate: class {
    func didUpdate(isBusy: Bool)
    func didFetchHorses()
    func didAdd()
    func didFail(with error: Error)
}

protocol AddFeedViewModeling: class {
    var delegate: AddFeedViewModelDelegate? { get set }
    var horseID: Int? {get set}
    var horses: [Horse] { get set}
    func fetchHorses()
    func addFeed(name: String, amount: Int, horseID: Int)
}
