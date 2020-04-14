//
//  TokenAdapter.swift
//  HorseStable
//
//  Created by Lukas Korinek on 07/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Alamofire
import Foundation

final class TokenAdapter: RequestAdapter {
    private let keychainManager: KeychainManaging

    init(keychainManager: KeychainManaging) {
        self.keychainManager = keychainManager
    }

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest

        // validate token is present
        guard let accessToken = keychainManager.value(forKey: .accessToken) else {
            let apiError = APIError(error: NSLocalizedString("Invalid credentials", comment: "Credentials are not present"), code: 401, payload: nil)
            throw apiError
        }

        urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")

        return urlRequest
    }
}
