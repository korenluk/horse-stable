//
//  AddFeedViewController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 05/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

protocol AddFeedViewControlling {
    var coordinator: AddFeedCoordinating? {get set}
}

class AddFeedViewController: UIViewController, AddFeedViewControlling {
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: AddFeedViewModeling!
    
    var coordinator: AddFeedCoordinating?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var horsePickerView: UIPickerView!
    

    var name: String {
        return nameTextField.text ?? ""
    }
    
    var amount: Int {
        return Int(amountTextField.text ?? "0") ?? 0
    }
    
    private var isFormValid: Bool {
        return !name.isEmpty && amount != 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        horsePickerView.delegate = self
        horsePickerView.dataSource = self
        viewModel.delegate = self
        viewModel.fetchHorses()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePressed))
    }
    
    @objc func savePressed(_ sender: Any) {
        if isFormValid {
            if let id = viewModel.horseID{
                viewModel.addFeed(name: name, amount: amount, horseID: id)
            }
        }
    }
    
    func setupUI() {
        horsePickerView.reloadAllComponents()
        if viewModel.horses.count == 0 {
            horsePickerView.isUserInteractionEnabled = false
            let alertController = UIAlertController(title: "VOID", message: "You dont have any horses. Please add some.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel) { alert in
                self.coordinator?.done()
            })

            present(alertController, animated: true, completion: nil)
        }
    }
    
    func getIndex() -> Int {
        let defaultIndex = viewModel.horses.firstIndex { (horse) -> Bool in
            return horse.id == viewModel.horseID
        }
        if let index = defaultIndex{
            return Int(index)
        }
        return 0
    }
}

extension AddFeedViewController: AddFeedViewModelDelegate {
    func didFetchHorses() {
        if let id = viewModel.horseID {
            if id == 0 {
                if let id = viewModel.horses.first?.id {
                    viewModel.horseID = id
                }
            } else {
                viewModel.horseID = id
            }
        } else {
            viewModel.horseID = viewModel.horses.first?.id
        }
        setupUI()
        horsePickerView.selectRow(getIndex(), inComponent: 0, animated: false)
    }
    
    func didUpdate(isBusy: Bool) {
    }
    
    func didAdd() {
        coordinator?.done()
    }
    
    func didFail(with error: Error) {
        print(error)
    }
}

extension AddFeedViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.horses.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return viewModel.horses[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.horseID = viewModel.horses[row].id
    }
}
