//
//  AddWorkPlaceViewController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 11/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

protocol AddWorkPlaceViewControlling {
    var coordinator: AddWorkPlaceCoordinating? {get set}
}

class AddWorkPlaceViewController: UIViewController, AddWorkPlaceViewControlling {
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: AddWorkPlaceViewModeling!
    
    var coordinator: AddWorkPlaceCoordinating?
    
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
            viewModel.addWorkPlace(name: name, capacity: capacity)
        }
    }
}

extension AddWorkPlaceViewController: AddWorkPlaceViewModelDelegate {
    func didUpdate(isBusy: Bool) {
    }
    
    func didAdd() {
        coordinator?.done()
    }
    
    func didFail(with error: Error) {
        print(error)
    }
}
