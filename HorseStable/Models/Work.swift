//
//  Work.swift
//  HorseStable
//
//  Created by Lukas Korinek on 23/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

struct Work: Codable, Comparable {
    let id: Int
    var name: String
    var horseID: Int
    var date: String
    var stableID: Int
    
    static func < (lhs: Work, rhs: Work) -> Bool {
        lhs.id < rhs.id
    }
}
