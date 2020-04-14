//
//  WorkPlaceDetailViewController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 11/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

protocol WorkPlaceDetailViewControlling {
    var coordinator: WorkPlaceDetailCoordinating? { get set }
}

class WorkPlaceDetailViewController: UIViewController, WorkPlaceDetailViewControlling {
    var coordinator: WorkPlaceDetailCoordinating?

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: WorkPlaceDetailViewModeling!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var capacityTextField: UITextField!
    
    
    var name: String {
        return nameTextField.text ?? ""
    }
    
    var capacity: Int {
        return Int(capacityTextField.text ?? "") ?? 0
    }
    
    private var isFormValid: Bool {
        return !name.isEmpty
    }
    
    // MARK: - Object lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Work Place Detail"
        viewModel.delegate = self
        viewModel.fetchWorkPlace()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
    }
    
    @objc func edit() {
        nameTextField.isEnabled = true
        capacityTextField.isEnabled = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePressed))
    }
    
     @objc func savePressed(_ sender: Any) {
        if isFormValid{
            viewModel.patchWorkPlace(name: name, capacity: capacity)
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
            nameTextField.isEnabled = false
            capacityTextField.isEnabled = false
        }
    }
    
    func setupUI() {
        nameTextField.text = viewModel.workPlace.name
        capacityTextField.text = viewModel.workPlace.capacity.description
        nameTextField.isEnabled = false
        capacityTextField.isEnabled = false
    }
}

// MARK: HorseViewModelingDelegate methods
extension WorkPlaceDetailViewController: WorkPlaceDetailViewModelDelegate {
    func didFetchWorkPlace() {
        setupUI()
    }
    
    func didUpdateWorkPlace() {
    }
    
    func didUpdate(isBusy: Bool) {
        
    }
    
    func didFail(with error: Error) {
        print(error)
    }
}
