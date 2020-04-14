//
//  FeedRouter.swift
//  HorseStable
//
//  Created by Lukas Korinek on 05/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import Alamofire
import Foundation

enum FeedRouter: URLRequestConvertible {
    case feeds
    case feed(identifier: Int)
    case createFeed(name: String, amount: Int, horseID: Int, feedTypeID: Int)
    case updateFeed(identifier: Int, name: String, amount: Int)
    case deleteFeed(identifier: Int)
    
    var path: String {
        switch self {
        case .feeds:
            return "/feed"
        case let .feed(identifier):
            return "/feed/\(identifier)"
        case .createFeed:
            return "/feed"
        case let .deleteFeed(identifier):
            return "/feed/\(identifier)"
        case let .updateFeed(identifier,_,_):
            return "/feed/\(identifier)"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case  .feeds, .feed, .deleteFeed:
            return [:]
        case let .createFeed(name, amount, horseID, feedTypeID):
            return ["name":name, "amount":amount, "horseID": horseID, "feedTypeID":feedTypeID]
        case let .updateFeed(_ ,name, amount):
            return ["name":name, "amount":amount]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .feeds,.feed:
            return .get
        case .createFeed:
            return .post
        case .updateFeed:
            return .patch
        case .deleteFeed:
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
