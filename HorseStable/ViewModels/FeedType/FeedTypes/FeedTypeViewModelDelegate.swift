//
//  FeedTypeViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 04/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import Foundation

protocol FeedTypesViewModelDelegate: class {
    func didUpdate(isBusy: Bool)
    func didUpdateFeedTypes()
    func didDeleteFeedType()
    func didFail(with error: Error)
}

protocol FeedTypesViewModeling: class {
    var delegate: FeedTypesViewModelDelegate? { get set }
    
    func updateFeedTypes()
    func numberOfFeedTypes() -> Int
    func feedType(at index: Int) -> FeedType
    func delete(identifier: Int)
}
