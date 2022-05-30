//
//  HomePresenter.swift
//  DigihuntingApp
//
//  Created by Daniel Cano Platero on 12/5/22.
//

import Foundation

final class HomePresenter: HomePresenterInterface {
    
    let interactor: HomeInteractorInterface
    weak var view: HomeViewControllerInterface?
    var router: HomeRouterInterface?
    
    init(interactor: HomeInteractorInterface, router: HomeRouterInterface) {
        self.interactor = interactor
        self.router = router
    }
    
    func getCity() {
        view?.showLoading()
        interactor.getCity { [weak self] result in
            switch result {
            case .success(let data):
                self?.view?.cities.append(contentsOf: data ?? [])
                self?.view?.showTableView()
                self?.view?.reloadTableViewContent()
            case .failure(let error):
                switch error {
                case .emptyData:
                    self?.view?.showNoResultsLabel()
                default:
                    self?.view?.showServerError()
                }
            }
            self?.view?.dismissLoading()
        }
    }
    
    func navigateToDetailVC(city: CityModel) {
        guard let view = view else { return }
        router?.navigateToDetailViewController(for: view, data: city)
    }
}
