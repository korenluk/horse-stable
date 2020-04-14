//
//  FeedsViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 15/03/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

class FeedViewModel: FeedViewModeling {
        
    weak var delegate: FeedViewModelDelegate?
    
    private var isFetching: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isFetching)
        }
    }
    private let feedType: FeedType
    private var feeds = [Feed]()
    private let feedTypeService: FeedTypeService
    private let feedService: FeedService
    
    init(feedType: FeedType, feedTypeService: FeedTypeService, feedService: FeedService) {
        self.feedType = feedType
        self.feedTypeService = feedTypeService
        self.feedService = feedService
    }
    
    func updateFeed() {
        fetchFeed()
    }
    
    func numberOfFeed() -> Int {
        return feeds.count
    }
    
    func feed(at index: Int) -> Feed {
        return feeds[index]
    }
    
    func delete(identifier: Int) {
        deleteFeed(identifier: identifier)
    }
}

private extension FeedViewModel {
    func fetchFeed() {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        feedTypeService.feedTypesFeed(identifier: feedType.id) { [weak self] result in
            guard let self = self else {
                return
            }
            self.isFetching = false
            
            switch result {
            case let .success(feeds):
                self.feeds = feeds
                self.feeds.sort()
                self.delegate?.didUpdateFeed()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
    
    func deleteFeed(identifier: Int) {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        feedService.deleteFeed(identifier: identifier) {[weak self] result in
            guard let self = self else {
                return
            }
            self.isFetching = false
            
            switch result {
            case .success(_):
                self.delegate?.didDeleteFeed()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}
