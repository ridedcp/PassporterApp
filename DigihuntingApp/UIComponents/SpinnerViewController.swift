//
//  SpinnerViewController.swift
//  DigihuntingApp
//
//  Created by Daniel Cano Platero on 12/5/22.
//

import UIKit

protocol SpinnerViewInterface {
    func startLoading(in viewController: UIViewController)
    func stopLoading()
}

final class SpinnerViewController: UIViewController, SpinnerViewInterface {
    private var spinner = UIActivityIndicatorView(style: .large)

    internal override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.7)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func startLoading(in viewController: UIViewController) {
        viewController.addChild(self)
        view.frame = viewController.view.frame
        viewController.view.addSubview(view)
        didMove(toParent: viewController)
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.willMove(toParent: nil)
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
}
