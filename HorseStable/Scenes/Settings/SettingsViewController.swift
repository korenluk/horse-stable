//
//  SettingsViewController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 07/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol SettingsViewControlling {
    var coordinator: SettingsCoordinating? {get set}
}

class SettingsViewController: UIViewController, SettingsViewControlling {
    var coordinator: SettingsCoordinating?
    
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: SettingsViewModeling!
    
    @IBAction func changeStable(_ sender: Any) {
        coordinator?.changeStable?()
    }
    @IBAction func logout(_ sender: Any) {
        viewModel.logout()
    }


    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self

    }
}

// MARK: View model delegate
extension SettingsViewController: SettingsViewModelingDelegate {
    func didUpdate(isBusy: Bool) {
    }

    func didLogout() {
        coordinator?.logout()
    }

    func didFail(with error: Error) {
        didLogout()
    }
}
