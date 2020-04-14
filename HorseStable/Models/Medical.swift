//
//  Medical.swift
//  HorseStable
//
//  Created by Lukas Korinek on 25/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

struct Medical: Codable, Comparable {
    var id: Int
    var name: String
    var date: String
    var horseID: Int
    
    static func < (lhs: Medical, rhs: Medical) -> Bool {
        lhs.id < rhs.id
    }
}
