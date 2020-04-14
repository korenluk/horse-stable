//
//  LoginViewController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 07/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol LoginViewControlling {
    var logIn: (() -> Void)? { get set }
    var coordinator: LoginCoordinating? {get set}
}

class LoginViewController: UIViewController, LoginViewControlling {
    var coordinator: LoginCoordinating?
    
    
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: LoginViewModeling!
    
    var logIn: (() -> Void)?

    // MARK: - UI
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func register(_ sender: Any) {
        coordinator?.register()
    }
    
    // MARK: - Private properties
    private var username: String {
        return usernameTextField.text ?? ""
    }

    private var password: String {
        return passwordTextField.text ?? ""
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupUI()
    }

    deinit {
        print("LOGIN CONTROLLER DEINIT")
    }
}

// MARK: - IBActions
private extension LoginViewController {
    @IBAction func login(_ sender: Any) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            return
        }
        viewModel.login(username: username, password: password)
    }
}

// MARK: - Private
private extension LoginViewController {
    func setupUI() {
        usernameTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .done

        passwordTextField.isSecureTextEntry = true
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}

// MARK: View model delegate
extension LoginViewController: LoginViewModelingDelegate {    
    func didUpdate(isBusy: Bool) {
    }

    func didAuthenticate() {
        logIn?()
    }

    func didFail(with error: Error) {
        let alertController = UIAlertController(title: NSLocalizedString("Authentication failed", comment: "Authentication error title"), message:
            error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK confirmation button title"), style: .default))

        present(alertController, animated: true, completion: nil)
    }
}
