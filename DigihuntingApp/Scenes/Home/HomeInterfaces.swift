//
//  HomeInterfaces.swift
//  DigihuntingApp
//
//  Created by Daniel Cano Platero on 12/5/22.
//

import Foundation

protocol HomeViewControllerInterface: AnyObject {
    var cities: [CityModel] { get set }
    func reloadTableViewContent()
    func showLoading()
    func dismissLoading()
    func showNoResultsLabel()
    func showTableView()
    func showServerError()
}

protocol HomePresenterInterface {
    func getCity()
    func navigateToDetailVC(city: CityModel)
}

protocol HomeInteractorInterface {
    func getCity(completion: @escaping (Result<Set<CityModel>?, NetworkingError>) -> Void)
}

protocol HomeRouterInterface {
    func navigateToDetailViewController(for view: HomeViewControllerInterface, data: CityModel)
}
