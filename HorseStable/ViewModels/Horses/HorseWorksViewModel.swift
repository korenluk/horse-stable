//
//  HorseWorksViewModel.swift
//  HorseStable
//
//  Created by Lukas Korinek on 31/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

class HorseWorksViewModel: HorseWorksViewModeling {
    var delegate: HorseWorksViewModelDelegate?
    
    private var isFetching: Bool = false {
        didSet {
            delegate?.didUpdate(isBusy: isFetching)
        }
    }
    internal var horse: Horse
    private var works = [Work]()
    private let horsesService: HorsesService
    private let worksService: WorksService
    
    init(horse: Horse, horsesService: HorsesService, worksService: WorksService) {
        self.worksService = worksService
        self.horsesService = horsesService
        self.horse = horse
    }
    
    func updateWorks() {
        fetchWorks()
    }
    
    func numberOfWorks() -> Int {
        works.count
    }
    
    func work(at index: Int) -> Work {
        return works[index]
    }
    
    func delete(identifier: Int) {
        deleteWork(identifier: identifier)
    }
}

extension HorseWorksViewModel {
    func fetchWorks() {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        horsesService.horseWorks(identifier: horse.id) { [weak self] result in
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
