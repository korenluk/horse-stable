//
//  APIManager.swift
//  HorseStable
//
//  Created by Lukas Korinek on 28/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//


import Alamofire
import Foundation

final class APIManager {
    let sessionManager: SessionManager
    
    lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        return decoder
    }()
    
    static var defaultURLSessionConfiguration: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        configuration.timeoutIntervalForRequest = TimeInterval(10 * 1000)
        
        return configuration
    }
    
    static var defaultSessionManager: SessionManager {
        return SessionManager(configuration: APIManager.defaultURLSessionConfiguration)
    }
    
    init(
        sessionManager: SessionManager = APIManager.defaultSessionManager,
        requestAdapter: RequestAdapter? = nil
        ) {
        self.sessionManager = sessionManager
        sessionManager.adapter = requestAdapter
    }
}

extension APIManager: APIManaging {
    func request<T: Decodable>(request: Alamofire.URLRequestConvertible, completion: @escaping (Swift.Result<T, Error>) -> Void) {
        sessionManager.request(request).validate().responseData(completionHandler: { [weak self] response in
            guard let `self` = self else {
                return
            }
            
            switch response.result {
            case let .success(response):
                do {
                    let object = try self.jsonDecoder.decode(T.self, from: response)
                    completion(.success(object))
                } catch {
                    // parsing error
                    completion(.failure(error))
                }
            case let .failure(requestError):
                // try parse server error if any data, else return request error
                guard let data = response.data else {
                    completion(.failure(requestError))
                    return
                }
                do {
                    let apiError = try self.jsonDecoder.decode(APIError.self, from: data)
                    completion(.failure(apiError))
                } catch {
                    completion(.failure(requestError))
                }
            }
        })
    }
}
