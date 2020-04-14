//
//  AddHorseViewController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 29/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol AddHorseViewControlling {
    var coordinator: AddHorseCoordinating? {get set}
}

class AddHorseViewController: UIViewController, AddHorseViewControlling {
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: AddHorseViewModeling!
    
    var coordinator: AddHorseCoordinating?
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var genderPickerView: UIPickerView!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var breedTextField: UITextField!
    
    let genders = ["Male","Female"]
    var gender = "Male"
    
    var name: String {
        return nameTextField.text ?? ""
    }
    
    var color: String {
        return colorTextField.text ?? ""
    }
    
    var breed: String {
        return breedTextField.text ?? ""
    }

    
    private var isFormValid: Bool {
        return !name.isEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Horse"
        viewModel.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePressed))
        
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        

        birthDatePicker.locale = getPreferredLocale()
    }
    
    func getPreferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
    
    @objc func savePressed(_ sender: Any) {
        let date = Formatter().getYYYYMMDD(from: birthDatePicker.date)
        if isFormValid {
            print(name)
            print(birthDatePicker.date)
            print(gender)
            print(color)
            print(breed)
            viewModel.addHorse(name: name, birth: date, gender: gender , color: color, breed: breed)
        }
    }
}

extension AddHorseViewController: AddHorseViewModelDelegate {
    func didUpdate(isBusy: Bool) {
    }
    
    func didAdd() {
        coordinator?.done()
    }
    
    func didFail(with error: Error) {
        print(error)
    }
}

extension AddHorseViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender = genders[row]
    }
    
}
