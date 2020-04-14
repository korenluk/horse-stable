//
//  RegisterViewController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 07/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol RegisterViewControlling {
    var coordinator: LoginCoordinating? {get set}
}

class RegisterViewController: UIViewController, RegisterViewControlling {
    var coordinator: LoginCoordinating?
    
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: RegisterViewModeling!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    
    @IBAction func register(_ sender: Any) {
        guard let name = nameTextField.text, let username = usernameTextField.text, let password = passwordTextField.text else {
            return
        }
        
        viewModel.register(name: name, username: username, password: password)
    }
    

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        //button.isEnabled = false
    }
}

// MARK: View model delegate
extension RegisterViewController: RegisterViewModelingDelegate {
    func didRegister() {
        coordinator?.done()
    }
    
    func didUpdate(isBusy: Bool) {
    }

    func didFail(with error: Error) {
        let alertController = UIAlertController(title: NSLocalizedString("Authentication failed", comment: "Authentication error title"), message:
            error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK confirmation button title"), style: .default))

        present(alertController, animated: true, completion: nil)
    }
}
