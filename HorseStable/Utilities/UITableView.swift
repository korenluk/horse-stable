//
//  UITableView.swift
//  HorseStable
//
//  Created by Lukas Korinek on 07/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifer: String {
        return String(describing: self) + "Identifier"
    }
}

extension UITableViewHeaderFooterView {
    class var reuseIdentifier: String {
        return String(describing: self) + "Identifier"
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(of type: T.Type, at indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifer, for: indexPath) as? T else {
            fatalError("Unable to instantiate cell of type \(type)")
        }

        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(ofType type: T.Type) -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Cannot deque a header/footer of type: \(type)")
        }

        return view
    }
}
