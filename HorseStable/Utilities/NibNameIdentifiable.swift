//
//  NibNameIdentifiable.swift
//  HorseStable
//
//  Created by Lukas Korinek on 29/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol NibNameIdentifiable {}

extension NibNameIdentifiable where Self: UIView {
    static var nibIdentifier: String {
        return String(describing: Self.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: nibIdentifier, bundle: Bundle(for: Self.self))
    }
}
