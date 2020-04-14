//
//  DetailViewController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 31/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol DetailViewControlling {
    var coordinator: DetailCoordinating? { get set }
}

class DetailViewController: UIViewController, DetailViewControlling {
    var coordinator: DetailCoordinating?

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: DetailViewModeling!

    @IBAction func horseDetail(_ sender: Any) {
        print("HORSE DETAIL")
        coordinator?.horseDetail()
        
    }
    @IBAction func workDetail(_ sender: Any) {
        print("WORK DETAIL")
        coordinator?.workDetail()
    }
    @IBAction func medicDetail(_ sender: Any) {
        print("MEDICAL DETAIL")
        coordinator?.medicalDetail()
    }
    
    // MARK: - Object lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(viewModel.horse.name)".uppercased()
        viewModel.delegate = self
    }
    
    
}




// MARK: HorseViewModelingDelegate methods
extension DetailViewController: DetailViewModelDelegate {
    func didFetchHorse() {
        
    }
    
    func didUpdateHorse() {
        
    }
    
    func didUpdate(isBusy: Bool) {
    }
    
    
    func didFail(with error: Error) {
        print(error)
    }
}
