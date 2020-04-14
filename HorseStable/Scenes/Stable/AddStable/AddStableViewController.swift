//
//  AddStableViewController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 20/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol AddStableViewControlling {
    var coordinator: AddStableCoordinating? {get set}
}

class AddStableViewController: UIViewController, AddStableViewControlling {
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: AddStableViewModeling!
    
    var coordinator: AddStableCoordinating?
    

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var capacityTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    
    
    var name: String {
        return nameTextField.text ?? ""
    }
    
    var capacity: Int {
        return Int(capacityTextField.text ?? "") ?? 0
    }
    
    private var isFormValid: Bool {
        return !name.isEmpty && capacity != 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self

    }
    
    @IBAction func addPressed(_ sender: Any) {
        if isFormValid {
            viewModel.addStable(name: name, capacity: capacity)
        }
    }
}

extension AddStableViewController: AddStableViewModelDelegate {
    func didUpdate(isBusy: Bool) {
        
    }
    
    func didAdd() {
        coordinator?.done()
    }
    
    func didFetchHorses(){
    }
    
    func didFail(with error: Error) {
        print(error)
    }
}

