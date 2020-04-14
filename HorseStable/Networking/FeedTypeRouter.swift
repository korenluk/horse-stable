//
//  FeedTypeRouter.swift
//  HorseStable
//
//  Created by Lukas Korinek on 04/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import Alamofire
import Foundation

enum FeedTypeRouter: URLRequestConvertible {
    case feedTypes
    case feedType(identifier: Int)
    case createFeedTypeAll(name: String, capacity: Int, actualCapacity: Int, stableID: Int)
    case createFeedType(name: String, stableID:Int)
    case updateFeedType(identifier: Int, name: String, capacity: Int, actualCapacity: Int)
    case deleteFeedType(identifier: Int)
    case feedTypeFeeds(identifier: Int)
    
    var path: String {
        switch self {
        case .feedTypes:
            return "/feedType"
        case let .feedType(identifier):
            return "/feedType/\(identifier)"
        case .createFeedTypeAll,.createFeedType:
            return "/feedType"
        case let .deleteFeedType(identifier):
            return "/feedType/\(identifier)"
        case let .updateFeedType(identifier,_,_,_):
            return "/feedType/\(identifier)"
        case let .feedTypeFeeds(identifier):
            return "/feedType/\(identifier)/feeds"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case  .feedTypes, .feedType, .deleteFeedType, .feedTypeFeeds:
            return [:]
        case let .createFeedTypeAll(name, capacity, actualCapacity, stableID):
            return ["name":name, "capacity":capacity, "actualCapacity":actualCapacity,"stableID":stableID]
        case let .createFeedType(name, stableID):
            return ["name":name,"stableID":stableID]
        case let .updateFeedType(_ ,name, capacity, actualCapacity):
            return ["name":name, "capacity":capacity,"actualCapacity":actualCapacity]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .feedTypes,.feedType, .feedTypeFeeds:
            return .get
        case .createFeedTypeAll, .createFeedType:
            return .post
        case .updateFeedType:
            return .patch
        case .deleteFeedType:
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
