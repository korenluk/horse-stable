//
//  Feed.swift
//  HorseStable
//
//  Created by Lukas Korinek on 15/03/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import Foundation

struct Feed: Codable, Comparable {
    let id: Int
    var name: String
    var horseID: Int
    var feedTypeID: Int
    var amount: Int
    
    static func < (lhs: Feed, rhs: Feed) -> Bool {
        lhs.id < rhs.id
    }
}
