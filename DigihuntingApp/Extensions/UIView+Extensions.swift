//
//  UIView+Extensions.swift
//  DigihuntingApp
//
//  Created by Daniel Cano Platero on 12/5/22.
//

import UIKit

extension UIView {
    func addAutolayoutView(_ views: [UIView]) {
        views.forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
