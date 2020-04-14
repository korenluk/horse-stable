//
//  FeedCell.swift
//  HorseStable
//
//  Created by Lukas Korinek on 05/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
