//
//  AddMedicalViewController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 25/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit
import UserNotifications

protocol AddMedicalViewControlling {
    var coordinator: AddMedicalCoordinating? {get set}
}

class AddMedicalViewController: UIViewController, AddMedicalViewControlling {
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: AddMedicalViewModeling!
    
    var coordinator: AddMedicalCoordinating?
    
    let userNotificationCenter = UNUserNotificationCenter.current()

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    
    var name: String {
        return nameTextField.text ?? ""
    }
    
    
    private var isFormValid: Bool {
        return !name.isEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.locale = getPreferredLocale()
        viewModel.delegate = self
        navigationItem.title = "Add Medical"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addPressed))

    }
    
    @IBAction func addPressed(_ sender: Any) {
        let date = Formatter().getYYYYMMDD(from: datePicker.date)
        if isFormValid {
            viewModel.addMedical(name: name, date: date)
            setNotification()
        }
    }
    
    func getPreferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
    
    func setNotification() -> Void {
        let manager = LocalNotificationManager()
        manager.addNotification(title: name, date: datePicker.date)
        manager.schedule()
    }
}

extension AddMedicalViewController: AddMedicalViewModelDelegate {
    func didUpdate(isBusy: Bool) {
        
    }
    
    func didAdd() {
        coordinator?.done()
    }
    
    func didFail(with error: Error) {
        print(error)
    }
}
