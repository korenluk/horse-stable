//
//  FeedsViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 15/03/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import Foundation

protocol FeedViewModelDelegate: class {
    func didUpdate(isBusy: Bool)
    func didUpdateFeed()
    func didDeleteFeed()
    func didFail(with error: Error)
}

protocol FeedViewModeling: class {
    var delegate: FeedViewModelDelegate? { get set }
    func updateFeed()
    func numberOfFeed() -> Int
    func feed(at index: Int) -> Feed
    func delete(identifier: Int)
}
