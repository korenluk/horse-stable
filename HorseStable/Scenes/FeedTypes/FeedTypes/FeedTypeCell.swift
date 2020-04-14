//
//  FeedTypeCell.swift
//  HorseStable
//
//  Created by Lukas Korinek on 04/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

class FeedTypeCell: UITableViewCell, NibNameIdentifiable {
    struct Input {
        let name: String
        let capacity: Int?
        let actualCapacity: Int?
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var capacityLabel: UILabel!
    
    func configure(with input: Input) {
        progressView.layer.borderColor = UIColor.black.cgColor
        progressView.layer.borderWidth = 0.2
        progressView.layer.cornerRadius = 5
        progressView.clipsToBounds = true
        nameLabel.text = input.name
        if let capacity = input.capacity, let actualCapacity = input.actualCapacity {
            let progress = Float(actualCapacity)/Float(capacity)
            print(progress)
            progressView.setProgress(progress, animated: false)
            capacityLabel.text = "\(actualCapacity)/ \(capacity)"
        } else {
            progressView.trackTintColor = .systemRed
            capacityLabel.text = "Capacity not set."
        }
        
    }
}
