//
//  AddWork.swift
//  HorseStable
//
//  Created by Lukas Korinek on 28/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol AddWorkViewControlling {
    var coordinator: AddWorkCoordinating? {get set}
}

class AddWorkViewController: UIViewController, AddWorkViewControlling {
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: AddWorkViewModeling!
    
    var coordinator: AddWorkCoordinating?
    

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var horsePickerView: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    var name: String {
        return nameTextField.text ?? ""
    }
    
    private var isFormValid: Bool {
        return !name.isEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Work"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePressed))
        viewModel.delegate = self
        horsePickerView.delegate = self
        horsePickerView.dataSource = self
        datePicker.locale = getPreferredLocale()
        datePicker.date = viewModel.date
        viewModel.fetchHorses()
    }
    
    @objc func savePressed(_ sender: Any) {
        let date = Formatter().getYYYYMMDD(from: datePicker.date)
        if isFormValid {
            if let id = viewModel.horseID {
                viewModel.addWork(name: name, horseID: "\(id)", date: date)
            }
        }
    }
    
    func setupUI() {
        horsePickerView.reloadAllComponents()
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
    
    func getPreferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
}

extension AddWorkViewController: AddWorkViewModelDelegate {
    func didUpdate(isBusy: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = isBusy
    }
    
    func didAdd() {
        coordinator?.done()
    }
    
    func didFetchHorses(){
        if let id = viewModel.horseID {
            if id == 0 {
                if let id = viewModel.horses.first?.id {
                    viewModel.horseID = id
                }
            } else {
                viewModel.horseID = id
            }
        }
        setupUI()
        horsePickerView.selectRow(getIndex(), inComponent: 0, animated: false)
    }
    
    func didFail(with error: Error) {
        print(error)
    }
}

extension AddWorkViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
