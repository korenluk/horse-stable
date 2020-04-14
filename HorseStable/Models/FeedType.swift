//
//  FeedType.swift
//  HorseStable
//
//  Created by Lukas Korinek on 04/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import Foundation

struct FeedType: Codable, Comparable {
    let id: Int
    var name: String
    var capacity: Int?
    var actualCapacity: Int?
    var stableID: Int
    
    static func < (lhs: FeedType, rhs: FeedType) -> Bool {
        lhs.id < rhs.id
    }
}
