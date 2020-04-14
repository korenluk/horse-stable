//
//  WorkPlaceRouter.swift
//  HorseStable
//
//  Created by Lukas Korinek on 10/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import Alamofire
import Foundation

enum WorkPlaceRouter: URLRequestConvertible {
    case workPlaces
    case workPlace(identifier: Int)
    case createWorkPlace(name: String, capacity: Int, stableID: Int)
    case updateWorkPlace(identifier: Int, name: String, capacity: Int, stableID: Int)
    case deleteWorkPlace(identifier: Int)
    case workPlaceWorks(identifier: Int)
    
    var path: String {
        switch self {
        case .workPlaces:
            return "/workPlace"
        case let .workPlace(identifier):
            return "/workPlace/\(identifier)"
        case .createWorkPlace:
            return "/workPlace"
        case let .deleteWorkPlace(identifier):
            return "/workPlace/\(identifier)"
        case let .updateWorkPlace(identifier,_,_,_):
            return "/workPlace/\(identifier)"
        case let .workPlaceWorks(identifier):
            return "/workPlace/\(identifier)/works"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case  .workPlaces, .workPlace, .deleteWorkPlace, .workPlaceWorks:
            return [:]
        case let .createWorkPlace(name, capacity ,stableID):
            return ["name":name,"capacity":capacity, "stableID":stableID]
        case let .updateWorkPlace(_ ,name, capacity, stableID):
            return ["name":name, "capacity":capacity, "stableID":stableID]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .workPlaces,.workPlace, .workPlaceWorks:
            return .get
        case .createWorkPlace:
            return .post
        case .updateWorkPlace:
            return .patch
        case .deleteWorkPlace:
            return .delete
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(fileURLWithPath: "http://localhost:8080/api")
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        
        request.httpMethod = method.rawValue
        
        let encoding = URLEncoding(destination: .methodDependent, arrayEncoding: .brackets, boolEncoding: .literal)
        let finalUrl = try encoding.encode(request, with: parameters)
        print(finalUrl)
        print(parameters)
        return try encoding.encode(request, with: parameters)
    }
}

