//
//  Router.swift
//  HorseStable
//
//  Created by Lukas Korinek on 28/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Alamofire
import Foundation

enum HorseRouter: URLRequestConvertible {
    case horses
    case horse(identifier: Int)
    case createHorse(name: String, birth: String, gender: String, color: String, breed: String, userID: String, stableID: String)
    case updateHorse(identifier: Int, name: String, birth: String)
    case deleteHorse(identifier: Int)
    case horseWorks(identifier: Int)
    case horseMedical(identifier: Int)
    
    var path: String {
        switch self {
        case .horses:
            return "/horse"
        case let .horse(identifier):
            return "/horse/\(identifier)"
        case .createHorse:
            return "/horse"
        case let .deleteHorse(identifier):
            return "/horse/\(identifier)"
        case let .updateHorse(identifier,_,_):
            return "/horse/\(identifier)"
        case let .horseWorks(identifier):
            return "/horse/\(identifier)/works"
        case let .horseMedical(identifier):
            return "/horse/\(identifier)/medical"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case  .horses, .horse, .deleteHorse, .horseWorks, .horseMedical:
            return [:]
        case let .createHorse(name, birth, gender, color, breed, userID, stableID):
            return ["name":name,"birth":birth,"gender":gender,"color":color,"breed":breed,"userID": userID,"stableID": stableID]
        case let .updateHorse(_ ,name, birth):
            return ["name":name,"birth":birth]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .horses,.horse, .horseWorks, .horseMedical:
            return .get
        case .createHorse:
            return .post
        case .updateHorse:
            return .patch
        case .deleteHorse:
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
