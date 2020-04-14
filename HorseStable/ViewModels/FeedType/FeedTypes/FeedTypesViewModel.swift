//
//  FeedTypeViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 04/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

class FeedTypesViewModel: FeedTypesViewModeling {
        
    weak var delegate: FeedTypesViewModelDelegate?
    
    private var isFetching: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isFetching)
        }
    }
    private var feedTypes = [FeedType]()
    private let feedTypeService: FeedTypeService
    private let stableService: StableService
    
    init(feedTypeService: FeedTypeService, stableService: StableService) {
        self.feedTypeService = feedTypeService
        self.stableService = stableService
    }
    
    func updateFeedTypes() {
        fetchFeedTypes()
    }
    
    func numberOfFeedTypes() -> Int {
        return feedTypes.count
    }
    
    func feedType(at index: Int) -> FeedType {
        return feedTypes[index]
    }
    
    func delete(identifier: Int) {
        deleteFeedType(identifier: identifier)
    }
}

private extension FeedTypesViewModel {
    func fetchFeedTypes() {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        let id = UserDefaults.standard.integer(forKey: "stableID")
        stableService.stableFeedTypes(identifier: id) { [weak self] result in
            guard let self = self else {
                return
            }
            self.isFetching = false
            
            switch result {
            case let .success(feedType):
                self.feedTypes = feedType
                self.feedTypes.sort()
                self.delegate?.didUpdateFeedTypes()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
    
    func deleteFeedType(identifier: Int) {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        feedTypeService.deleteFeedType(identifier: identifier) {[weak self] result in
            guard let self = self else {
                return
            }
            self.isFetching = false
            
            switch result {
            case .success(_):
                self.delegate?.didDeleteFeedType()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}
