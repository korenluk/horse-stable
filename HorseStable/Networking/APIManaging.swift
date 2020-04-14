//
//  APIManaging.swift
//  HorseStable
//
//  Created by Lukas Korinek on 28/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Alamofire
import Foundation

protocol APIManaging {
    func request<T: Decodable>(request: Alamofire.URLRequestConvertible, completion _: @escaping (Swift.Result<T, Error>) -> Void)
}
