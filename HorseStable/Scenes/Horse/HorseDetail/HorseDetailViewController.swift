//
//  Horses.swift
//  HorseStable
//
//  Created by Lukas Korinek on 29/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol HorseDetailViewControlling {
    var coordinator: HorseDetailCoordinating? { get set }
}

class HorseDetailViewController: UIViewController, HorseDetailViewControlling {
    var coordinator: HorseDetailCoordinating?

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: HorseDetailViewModeling!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    var name: String {
        return nameTextField.text ?? ""
    }
    
    private var isFormValid: Bool {
        return !name.isEmpty
    }
    
    // MARK: - Object lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Horse Detail"
        viewModel.delegate = self
        viewModel.fetchHorse()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
        datePicker.locale = getPreferredLocale()
        datePicker.setDate(Formatter().getYYYYMMDD(from: viewModel.horse.birth), animated: true)
        
    }
    
    @objc func edit() {
        nameTextField.isEnabled = true
        datePicker.isEnabled = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePressed))
    }
    
     @objc func savePressed(_ sender: Any) {
        let date = Formatter().getYYYYMMDD(from: datePicker.date)
        if isFormValid{
            viewModel.patchHorse(name: name, birth: date)
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
            nameTextField.isEnabled = false
            datePicker.isEnabled = false
        }
    }
    
    func setupUI() {
        nameTextField.text = viewModel.horse.name
        nameTextField.isEnabled = false
        datePicker.isEnabled = false
    }
    
    func getPreferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
}




// MARK: HorseViewModelingDelegate methods
extension HorseDetailViewController: HorseDetailViewModelDelegate {
    func didFetchHorse() {
        setupUI()
    }
    
    func didUpdateHorse() {
        navigationController?.navigationBar.backItem?.title = viewModel.horse.name.uppercased()
    }
    
    func didUpdate(isBusy: Bool) {
    }
    
    
    func didFail(with error: Error) {
        print(error)
    }
}
