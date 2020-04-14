//
//  AddFeedTypeController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 04/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

protocol AddFeedTypeViewControlling {
    var coordinator: AddFeedTypeCoordinating? {get set}
}

class AddFeedTypeViewController: UIViewController, AddFeedTypeViewControlling {
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: AddFeedTypeViewModeling!
    
    var coordinator: AddFeedTypeCoordinating?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var capacityTextField: UITextField!
    @IBOutlet weak var actualCapacityTextField: UITextField!
    
    var name: String {
        return nameTextField.text ?? ""
    }
    
    var capacity: Int? {
        return Int(capacityTextField.text ?? "")
    }
    
    var actualCapacity: Int? {
        return Int(actualCapacityTextField.text ?? "")
    }
    
    private var isFormValid: Bool {
        return !name.isEmpty
    }
    
    @objc func didChangeInput(_ sender: Any) {
        if isFormValid {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePressed))
        navigationItem.rightBarButtonItem?.isEnabled = false
        nameTextField.addTarget(self, action: #selector(didChangeInput), for: .editingChanged)
    }
    
    @objc func savePressed(_ sender: Any) {
        if isFormValid {
            viewModel.addFeedType(name: name, capacity: capacity, actualCapacity: actualCapacity)
        }
    }
}

extension AddFeedTypeViewController: AddFeedTypeViewModelDelegate {
    func didUpdate(isBusy: Bool) {
    }
    
    func didAdd() {
        coordinator?.done()
    }
    
    func didFail(with error: Error) {
        print(error)
    }
}
