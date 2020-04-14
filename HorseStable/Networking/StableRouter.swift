//
//  StableRouter.swift
//  HorseStable
//
//  Created by Lukas Korinek on 20/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Alamofire
import Foundation

enum StableRouter: URLRequestConvertible {
    case stables
    case stable(identifier: Int)
    case createStable(name: String, capacity: Int, userID: String)
    case updateStable(identifier: Int, name: String, capacity: Int)
    case deleteStable(identifier: Int)
    case stableHorses(identifier: Int)
    case stableWorks(identifier: Int)
    case stableFeedTypes(identifier: Int)
    case stableWorkPlaces(identifier: Int)
    
    var path: String {
        switch self {
        case .stables:
            return "/stable"
        case let .stable(identifier):
            return "/stable/\(identifier)"
        case .createStable:
            return "/stable"
        case let .deleteStable(identifier):
            return "/stable/\(identifier)"
        case let .updateStable(identifier,_,_):
            return "/stable/\(identifier)"
        case let .stableHorses(identifier):
            return "/stable/\(identifier)/horses"
        case let .stableWorks(identifier):
            return "/stable/\(identifier)/works"
        case let .stableFeedTypes(identifier):
            return "/stable/\(identifier)/feedTypes"
        case let .stableWorkPlaces(identifier):
            return "/stable/\(identifier)/workPlaces"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case  .stables, .stable, .deleteStable, .stableHorses, .stableWorks, .stableFeedTypes, .stableWorkPlaces:
            return [:]
        case let .createStable(name, capacity, userID):
            return ["name":name, "capacity": capacity, "userID": userID]
        case let .updateStable(_ ,name, capacity):
            return ["name":name,"capacity":capacity]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .stables,.stable, .stableHorses, .stableWorks, .stableFeedTypes, .stableWorkPlaces:
            return .get
        case .createStable:
            return .post
        case .updateStable:
            return .patch
        case .deleteStable:
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
