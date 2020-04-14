//
//  KeychainManaging.swift
//  HorseStable
//
//  Created by Lukas Korinek on 07/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

// MARK: KeychainKeys
enum KeychainKey: String {
    case accessToken = "token"
}

protocol KeychainManaging {
    func store(value: String, forKey key: KeychainKey)
    func value(forKey key: KeychainKey) -> String?
    func removeValue(forKey key: KeychainKey)
    func clear()
}
