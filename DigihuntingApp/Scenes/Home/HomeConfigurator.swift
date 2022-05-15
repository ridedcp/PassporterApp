//
//  HomeConfigurator.swift
//  DigihuntingApp
//
//  Created by Daniel Cano Platero on 12/5/22.
//

import Foundation

final class HomeConfigurator {
    static func prepareScene() -> HomeViewController {
        let view = HomeViewController()
        let spinnerViewController = SpinnerViewController()
        let networking = Networking()
        let session = URLSession(configuration: .default)
        let repository = CommonRepository(networking: networking, session: session)
        let interactor = HomeInteractor(repository: repository)
        let router = HomeRouter()
        let presenter = HomePresenter(interactor: interactor, router: router)
        
        view.presenter = presenter
        view.spinner = spinnerViewController
        presenter.view = view
        presenter.router = router
        
        return view
    }
}
