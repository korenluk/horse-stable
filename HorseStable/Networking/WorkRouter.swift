//
//  WorkRouter.swift
//  HorseStable
//
//  Created by Lukas Korinek on 23/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Alamofire
import Foundation

enum WorkRouter: URLRequestConvertible {
    case works
    case work(identifier: Int)
    case createWork(name: String, horseID: String, date: String, stableID: String)
    case updateWork(identifier: Int, name: String, horseID: String, date: String, stableID: String)
    case deleteWork(identifier: Int)
    case horse(identifier: Int)
    
    var path: String {
        switch self {
        case .works:
            return "/work"
        case let .work(identifier):
            return "/work/\(identifier)"
        case .createWork:
            return "/work"
        case let .deleteWork(identifier):
            return "/work/\(identifier)"
        case let .updateWork(identifier,_,_,_,_):
            return "/work/\(identifier)"
        case let .horse(identifier):
            return "/work/\(identifier)/horse"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case  .works, .work, .deleteWork, .horse:
            return [:]
        case let .createWork(name, horseID, date, stableID):
            return ["name":name,"horseID":horseID, "date":date,"stableID":stableID]
        case let .updateWork(_,name, horseID, date, stableID):
            return ["name":name,"horseID":horseID,"date":date,"stableID":stableID]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .works,.work,.horse:
            return .get
        case .createWork:
            return .post
        case .updateWork:
            return .patch
        case .deleteWork:
            return .delete
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(fileURLWithPath: "http://localhost:8080/api/")
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        
        request.httpMethod = method.rawValue
        
        let encoding = URLEncoding(destination: .methodDependent, arrayEncoding: .brackets, boolEncoding: .literal)
        let finalUrl = try encoding.encode(request, with: parameters)
        print(finalUrl)
        print(parameters)
        return try encoding.encode(request, with: parameters)
    }
}
