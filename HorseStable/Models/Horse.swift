//
//  Horse.swift
//  HorseStable
//
//  Created by Lukas Korinek on 28/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import Foundation

struct Horse: Codable, Comparable {
    let id: Int
    var name: String
    var birth: String
    var gender: String?
    var color: String?
    var breed: String?
    var userID: String
    var stableID: Int
    static func < (lhs: Horse, rhs: Horse) -> Bool {
        lhs.id < rhs.id
    }
}
