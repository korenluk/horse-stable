//
//  WorkPlace.swift
//  HorseStable
//
//  Created by Lukas Korinek on 10/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import Foundation

struct WorkPlace: Codable, Comparable {
    var id: Int
    var name: String
    var capacity: Int
    var stableID: Int
    
    static func < (lhs: WorkPlace, rhs: WorkPlace) -> Bool {
        lhs.id < rhs.id
    }
}
