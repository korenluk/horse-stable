//
//  BlankNavigationController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 29/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

class BlankNavigationViewController: UINavigationController {
    // MARK: - Object lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension BlankNavigationViewController {
    func setupUI() {
        //navigationBar.setBackgroundImage(UIImage(), for: .default)
        //navigationBar.shadowImage = UIImage()
        //navigationBar.backgroundColor = .white
        //navigationBar.isTranslucent = true
        //navigationBar.tintColor = .white
    }
}
