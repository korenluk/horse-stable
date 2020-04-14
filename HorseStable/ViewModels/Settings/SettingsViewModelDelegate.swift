//
//  SettingsViewModelDelegate.swift
//  HorseStable
//
//  Created by Lukas Korinek on 08/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

protocol SettingsViewModelingDelegate: class {
    func didUpdate(isBusy: Bool)
    func didLogout()
    func didFail(with error: Error)
}

protocol SettingsViewModeling: class {
    var delegate: SettingsViewModelingDelegate? { get set }

    func logout()
}
