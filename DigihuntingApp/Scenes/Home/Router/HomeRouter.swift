//
//  HomeRouter.swift
//  DigihuntingApp
//
//  Created by Daniel Cano Platero on 12/5/22.
//

import UIKit
import SwiftUI

class HomeRouter: HomeRouterInterface {
    func navigateToDetailViewController(for view: HomeViewControllerInterface, data: CityModel) {
        let hostingViewController = UIHostingController(rootView: DetailView(city: data))
        if let view = view as? UIViewController {
            view.navigationController?.pushViewController(hostingViewController, animated: true)
        }
    }
}
