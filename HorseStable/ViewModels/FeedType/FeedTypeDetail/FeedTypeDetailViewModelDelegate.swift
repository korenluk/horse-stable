//
//  FeedTypeDetailViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 05/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

protocol FeedTypeDetailViewModelDelegate: class {
    func didUpdate(isBusy: Bool)
    func didUpdateFeedType()
    func didFetchFeedType()
    func didFail(with error: Error)
}

protocol FeedTypeDetailViewModeling: class {
    var delegate: FeedTypeDetailViewModelDelegate? { get set }
    var feedType: FeedType { get }
    func fetchFeedType()
    func patchFeedType(name: String, capacity: Int, actualCapacity: Int)
}
