//
//  UIImageView+Extensions.swift
//  DigihuntingApp
//
//  Created by Daniel Cano Platero on 13/5/22.
//

import UIKit

extension UIImageView {
    func loadImage(url: String) {
        DispatchQueue.global().async { [weak self] in
            guard let url = URL(string: url) else { return }
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
