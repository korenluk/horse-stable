//
//  Stable.swift
//  HorseStable
//
//  Created by Lukas Korinek on 20/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

struct Stable: Codable, Comparable {
    let id: Int
    var name: String
    var capacity: Int
    var userID: String
    static func < (lhs: Stable, rhs: Stable) -> Bool {
        lhs.id < rhs.id
    }
}
