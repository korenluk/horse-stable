//
//  WorksViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 23/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

class WorksViewModel: WorksViewModeling {
    var delegate: WorksViewModelDelegate?
    
    private var isFetching: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isFetching)
        }
    }
    internal var works = [Work]()
    internal var currentDayWorks = [Work]()
    private let worksService: WorksService
    private let stableService: StableService
    
    init(worksService: WorksService, stableService: StableService) {
        self.worksService = worksService
        self.stableService = stableService
    }
    
    func updateWorks() {
        fetchWorks()
    }
    
    func numberOfWorks(date: Date) -> Int {
        currentDayWorks = works.filter { (work) -> Bool in
            work.date == Formatter().getYYYYMMDD(from: date)
        }
        return currentDayWorks.count
    }
    
    func work(at index: Int) -> Work {
        return currentDayWorks[index]
    }
    
    func delete(identifier: Int) {
        deleteWork(identifier: identifier)
    }
}

extension WorksViewModel {
    func fetchWorks() {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        let id = UserDefaults.standard.integer(forKey: "stableID")
        stableService.stableWorks(identifier: id) { [weak self] result in
            guard let self = self else {
                return
            }
            self.isFetching = false
            
            switch result {
            case let .success(works):
                self.works = works
                self.works.sort()
                self.delegate?.didUpdateWorks()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
    
    func deleteWork(identifier: Int) {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        worksService.deleteWork(identifier: identifier) {[weak self] result in
            guard let self = self else {
                return
            }
            self.isFetching = false
            
            switch result {
            case let .success(response):
                print(response)
                print("DELETE OK")
                self.delegate?.didDeleteWork()
            case let .failure(error):
                print("DELETE FAIL")
                self.delegate?.didFail(with: error)
            }
        }
    }
}
