//
//  HomeViewController.swift
//  DigihuntingApp
//
//  Created by Daniel Cano Platero on 12/5/22.
//

import UIKit

final class HomeViewController: UIViewController {
    var presenter: HomePresenterInterface?
    var cities: [CityModel] = []
    var spinner: SpinnerViewInterface?
    var filteredCities = [CityModel]()
    var isSearching = false

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = Constants.searchSomeCityTitle
        searchBar.enablesReturnKeyAutomatically = false
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.estimatedRowHeight = 80
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private let statusLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        presenter?.getCity()
    }
    
    private func setupView() {
        navigationController?.navigationBar.isHidden = true
        view.addAutolayoutView([searchBar, statusLabel, tableView])
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        statusLabel.text = Constants.searchCityTitle
        statusLabel.textAlignment = .center
        statusLabel.textColor = .black
        view.backgroundColor = .white
        hideKeyboardWhenTappedAround()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            statusLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            statusLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Style.Spacing.spacingS),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Style.Spacing.spacingS),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController: HomeViewControllerInterface {
    func reloadTableViewContent() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showLoading() {
        spinner?.startLoading(in: self)
    }
    
    func dismissLoading() {
        spinner?.stopLoading()
    }
    
    func showNoResultsLabel() {
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.statusLabel.text = Constants.noResultsTitle
        }
    }
    
    func showServerError() {
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.statusLabel.text = Constants.somethingWrongTitle
        }
    }
    
    func showTableView() {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredCities.count
        } else {
            return cities.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        if isSearching {
            cell.configCell(with: filteredCities[indexPath.row])
        } else {
            cell.configCell(with: cities[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching {
            presenter?.navigateToDetailVC(city: filteredCities[indexPath.row])
        } else {
            presenter?.navigateToDetailVC(city: cities[indexPath.row])
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            isSearching = false
            showTableView()
        } else {
            isSearching = true
            filteredCities = cities.filter({ (city: CityModel) -> Bool in
                let title = city.name?.range(of: searchText)
                let address = city.address?.range(of: searchText)
                return title != nil || address != nil
            })
            
            if filteredCities.count > 0 {
                showTableView()
            } else {
                showNoResultsLabel()
            }
        }
        
        reloadTableViewContent()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        statusLabel.text = Constants.searchCityTitle
    }
}
