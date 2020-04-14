//
//  KeychainManager.swift
//  HorseStable
//
//  Created by Lukas Korinek on 07/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation
import KeychainSwift

final class KeychainManager {
    let keychain = KeychainSwift()
}

// MARK: Keychaing managing
extension KeychainManager: KeychainManaging {
    func store(value: String, forKey key: KeychainKey) {
        // store new value
        keychain.set(value, forKey: key.rawValue)
    }

    func value(forKey key: KeychainKey) -> String? {
        return keychain.get(key.rawValue)
    }

    func removeValue(forKey key: KeychainKey) {
        keychain.delete(key.rawValue)
    }

    func clear() {
        keychain.clear()
    }
}
