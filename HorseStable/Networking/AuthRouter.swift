//
//  AuthRouter.swift
//  HorseStable
//
//  Created by Lukas Korinek on 07/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Alamofire
import Foundation

enum AuthRouter: URLRequestConvertible {
    case login(username: String, password: String)
    case register(name: String, username: String, password: String)
    case logout
    case getStables(identifier: String)

    var method: HTTPMethod {
        switch self {
        case .getStables:
            return .get
        case .login, .register:
            return .post
        case .logout:
            return .delete
        }
    }

    var path: String {
        switch self {
        case .login:
            return "/login"
        case .register:
            return "/register"
        case .logout:
            return "/logout"
        case let .getStables(identifier):
            return "/\(identifier)/stables"
        }
    }

    var parameters: [String: Any] {
        switch self {
        case let .login(username, password):
            return ["username": username, "password": password]
        case let .register(name, username, password):
            return ["name": name, "username": username, "password": password]
        case .logout, .getStables:
            return [:]
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = URL(fileURLWithPath: "http://localhost:8080/api/users")

       var request = URLRequest(url: url.appendingPathComponent(path))
        
        request.httpMethod = method.rawValue
        
        let encoding = URLEncoding(destination: .methodDependent, arrayEncoding: .brackets, boolEncoding: .literal)
        let finalUrl = try encoding.encode(request, with: parameters)
        print(finalUrl)
        print(parameters)
        return try encoding.encode(request, with: parameters)
    }
}
