//
//  AddFeedViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 05/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import Foundation

class AddFeedViewModel: AddFeedViewModeling {
    weak var delegate: AddFeedViewModelDelegate?
    
    private var isFetching: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isFetching)
        }
    }
    internal var feedType: FeedType
    internal var horseID: Int?
    internal var horses = [Horse]()

    private let feedService: FeedService
    private let stableService: StableService
    
    init(feedType: FeedType, feedService: FeedService, stableService: StableService) {
        self.feedType = feedType
        self.feedService = feedService
        self.stableService = stableService
    }
    
    func addFeed(name: String, amount: Int, horseID: Int) {
        guard !isFetching else {
            return
        }
        isFetching = true
        feedService.addFeed(name: name, amount: amount, horseID: horseID, feedTypeID: feedType.id) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(_):
                self.delegate?.didAdd()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
    
    func fetchHorses() {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        let id = UserDefaults.standard.integer(forKey: "stableID")
        stableService.stableHorses(identifier: id) { [weak self] result in
            guard let self = self else {
                return
            }
            self.isFetching = false
            
            switch result {
            case let .success(horses):
                self.horses = horses
                self.horses.sort()
                self.delegate?.didFetchHorses()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}
