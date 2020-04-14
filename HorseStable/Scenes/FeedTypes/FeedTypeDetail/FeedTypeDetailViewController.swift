//
//  FeedTypeDetailViewController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 05/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

protocol FeedTypeDetailViewControlling {
    var coordinator: FeedTypeDetailCoordinating? { get set }
}

class FeedTypeDetailViewController: UIViewController, FeedTypeDetailViewControlling {
    var coordinator: FeedTypeDetailCoordinating?

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: FeedTypeDetailViewModeling!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var capacityTextField: UITextField!
    
    var name: String {
        return nameTextField.text ?? ""
    }
    
    var capacity: String {
        return capacityTextField.text ?? ""
    }
    
    private var isFormValid: Bool {
        return !name.isEmpty && !capacity.isEmpty
    }
    
    // MARK: - Object lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Feed Type Detail"
        viewModel.delegate = self
        viewModel.fetchFeedType()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
    }
    
    @objc func edit() {
        nameTextField.isEnabled = true
        capacityTextField.isEnabled = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePressed))
    }
    
     @objc func savePressed(_ sender: Any) {
        if isFormValid{
            if let capacity = Int(capacity) {
                viewModel.patchFeedType(name: name, capacity: capacity, actualCapacity: 0)
            } else {
                viewModel.patchFeedType(name: name, capacity: viewModel.feedType.capacity ?? 0, actualCapacity: 0)
            }
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
            nameTextField.isEnabled = false
            capacityTextField.isEnabled = false
        }
    }
    
    func setupUI() {
        nameTextField.text = viewModel.feedType.name
        capacityTextField.text = viewModel.feedType.capacity?.description
        nameTextField.isEnabled = false
        capacityTextField.isEnabled = false
    }
}

// MARK: HorseViewModelingDelegate methods
extension FeedTypeDetailViewController: FeedTypeDetailViewModelDelegate {
    func didFetchFeedType() {
        setupUI()
    }
    
    func didUpdateFeedType() {
    }
    
    func didUpdate(isBusy: Bool) {
        
    }
    
    func didFail(with error: Error) {
        print(error)
    }
}
