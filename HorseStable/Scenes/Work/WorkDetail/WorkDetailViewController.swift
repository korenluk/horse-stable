//
//  WorkDetailViewController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 28/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol WorkDetailViewControlling {
    var coordinator: WorkDetailCoordinating? { get set }
}

class WorkDetailViewController: UIViewController, WorkDetailViewControlling {
    var coordinator: WorkDetailCoordinating?

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: WorkDetailViewModeling!
    
    var horseID: Int?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var horsePickerView: UIPickerView!
    
    
    var name: String {
        return nameTextField.text ?? ""
    }
    
    private var isFormValid: Bool {
        return !name.isEmpty
    }
    
    // MARK: - Object lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Work Detail"
        viewModel.delegate = self
        horsePickerView.delegate = self
        horsePickerView.dataSource = self
        viewModel.fetchWork()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
        
        
    }
    
    @objc func edit() {
        nameTextField.isEnabled = true
        horsePickerView.isUserInteractionEnabled = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePressed))
    }
    
     @objc func savePressed(_ sender: Any) {
        if isFormValid {
            if let id = horseID {
                viewModel.patchWork(name: name, horseID: "\(id)", date: Date().description)
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
                nameTextField.isEnabled = false
                horsePickerView.isUserInteractionEnabled = false
            }
        }
    }
    
    func setupUI() {
        nameTextField.text = viewModel.work.name
        horsePickerView.reloadAllComponents()
        horsePickerView.isUserInteractionEnabled = false
        nameTextField.isEnabled = false
        
    }
    
    func getIndex() -> Int {
        let defaultIndex = viewModel.horses.firstIndex { (horse) -> Bool in
            return horse.id == viewModel.work.horseID
        }
        if let index = defaultIndex{
            return Int(index)
        }
        return 0
    }
}




// MARK: HorseViewModelingDelegate methods
extension WorkDetailViewController: WorkDetailViewModelDelegate {
    func didUpdateWork() {
        
    }
    
    func didFetchWork() {
        viewModel.fetchHorses()
    }
    
    func didFetchHorses(){
        setupUI()
        if let id = viewModel.horses.first?.id {
            horseID = id
        }
        horsePickerView.selectRow(getIndex(), inComponent: 0, animated: false)
    }
    
    func didUpdate(isBusy: Bool) {
        
    }
    
    
    func didFail(with error: Error) {
        print(error)
    }
}

extension WorkDetailViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
        horseID = viewModel.horses[row].id
    }
}


