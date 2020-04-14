//
//  AddFeedTypeViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 04/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import Foundation

class AddFeedTypeViewModel: AddFeedTypeViewModeling {
    weak var delegate: AddFeedTypeViewModelDelegate?
    
    private var isFetching: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isFetching)
        }
    }

    private let feedTypeService: FeedTypeService
    
    init(feedTypeService: FeedTypeService) {
        self.feedTypeService = feedTypeService
    }
    
    func addFeedType(name: String, capacity: Int?, actualCapacity: Int?) {
        guard !isFetching else {
            return
        }
        isFetching = true
        let id = UserDefaults.standard.integer(forKey: "stableID")
        feedTypeService.addFeedType(name: name, capacity: capacity, actualCapacity: actualCapacity, stableID: id) { [weak self] result in
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
}
