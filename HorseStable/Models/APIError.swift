//
//  APIError.swift
//  HorseStable
//
//  Created by Lukas Korinek on 29/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

// MARK: Enum for types & decodable
enum APIErrorType: String, Decodable {
    case minLength = "string.min"
}

// MARK: Help structures to read error messages
struct APIErrorPayload: Decodable {
    let errors: [APIErrorMessage]
}

struct APIErrorMessage: Decodable {
    let message: String
    let type: APIErrorType
}

// MARK: - Model class representing error from api
struct APIError: Decodable {
    let error: String
    let code: Int
    let payload: APIErrorPayload?
}

extension APIError: Error {}
