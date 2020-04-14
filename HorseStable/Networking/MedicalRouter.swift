//
//  MedicalRouter.swift
//  HorseStable
//
//  Created by Lukas Korinek on 26/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Alamofire
import Foundation

enum MedicalRouter: URLRequestConvertible {
    case medicals
    case medical(identifier: Int)
    case createMedical(name: String, date: String, horseID: Int)
    case updateMedical(identifier: Int, name: String, date: String)
    case deleteMedical(identifier: Int)
    
    var path: String {
        switch self {
        case .medicals:
            return "/medical"
        case let .medical(identifier):
            return "/medical/\(identifier)"
        case .createMedical:
            return "/medical"
        case let .deleteMedical(identifier):
            return "/medical/\(identifier)"
        case let .updateMedical(identifier,_,_):
            return "/medical/\(identifier)"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case  .medicals, .medical, .deleteMedical:
            return [:]
        case let .createMedical(name, date, horseID):
            return ["name":name, "date": date, "horseID": horseID]
        case let .updateMedical(_ ,name, date):
            return ["name":name,"date":date]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .medicals,.medical:
            return .get
        case .createMedical:
            return .post
        case .updateMedical:
            return .patch
        case .deleteMedical:
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
