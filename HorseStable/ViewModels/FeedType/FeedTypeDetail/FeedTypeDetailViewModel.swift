//
//  FeedTypeDetailViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 05/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

class FeedTypeDetailViewModel: FeedTypeDetailViewModeling {
    weak var delegate: FeedTypeDetailViewModelDelegate?
    
    private var isFetching: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isFetching)
        }
    }
    
    private(set) var feedType: FeedType
    private let feedTypeService: FeedTypeService
    
    init(feedType: FeedType, feedTypeService: FeedTypeService) {
        self.feedType = feedType
        self.feedTypeService = feedTypeService
    }
}

extension FeedTypeDetailViewModel {
    
    func fetchFeedType() {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        feedTypeService.fetchFeedType(identifier: feedType.id) { [weak self] result in
            guard let self = self else {
                return
            }
            self.isFetching = false
            
            switch result {
            case let .success(feedType):
                self.feedType = feedType
                self.delegate?.didFetchFeedType()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
    
    func patchFeedType(name: String, capacity: Int, actualCapacity: Int) {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        feedTypeService.patchFeedType(identifier: feedType.id, name: name, capacity: capacity, actualCapacity: actualCapacity) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(feedType):
                self.feedType.name = feedType.name
                self.delegate?.didUpdateFeedType()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}
