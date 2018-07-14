//
//  StrainsViewController.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-08.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit
import FoldingCell

class StrainsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StrainFavoriteDelegate {
    
    // MARK: - Property Declarations
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    var strainsTableView: UITableView!
    var strains = [Product]()
    var filteredStrains = [Product]()
    
    let closeHeight: CGFloat = 136
    let openHeight: CGFloat = 375
    var rowsCount: Int = 50
    var itemHeight: [CGFloat] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    var reuseIdentifier = "strainCell"
    let urlString = "http://app.haligrove.com/strainData.json"
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ApiService.shared.fetchJson(from: urlString) { [weak self] (data: [Product]) in
            self?.strains = data
            self?.activityIndicator.stopAnimating()
            self?.strainsTableView.reloadData()
        }
    }
    
    // MARK: - Class Methods
    func setupTableView() {
        navigationItem.title = "Strains"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        searchController.searchBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = ["All", "indica", "sativa", "hybrid"]
        searchController.searchBar.delegate = self
        
        strainsTableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), style: .plain)
        strainsTableView.register(StrainsCell.self, forCellReuseIdentifier: reuseIdentifier)
        strainsTableView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        strainsTableView.dataSource = self
        strainsTableView.delegate = self
        strainsTableView.separatorStyle = .none
        self.view.addSubview(strainsTableView)
        
        self.view.addSubview(activityIndicator)
        self.view.bringSubviewToFront(activityIndicator)
        activityIndicator.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        strainsTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.safeAreaLayoutGuide.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
    }
    
    private func setup() {
        itemHeight = Array(repeating: closeHeight, count: rowsCount)
        strainsTableView.estimatedRowHeight = closeHeight
        strainsTableView.rowHeight = UITableView.automaticDimension
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredStrains = strains.filter({(strain: Product) -> Bool in
            let doesCategoryMatch = (scope == "All") || (strain.type == scope)
            if searchBarIsEmpty() {
                return doesCategoryMatch
            } else {
                guard let name = strain.name else { return false }
                return doesCategoryMatch && name.lowercased().contains(searchText.lowercased())
            }
        })
        strainsTableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
   func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        strainsTableView.reloadData()
    }
    
    // MARK: - Delegate Methods
    func didTapStrainFavoritesButton(in cell: StrainsCell) {
        guard let indexTapped = strainsTableView.indexPath(for: cell) else { return }
        var thisStrain = strains[indexTapped.row]
        if isFiltering() {
           thisStrain = filteredStrains[indexTapped.row]
        }
        guard let hasFavorited = thisStrain.isFavorite else { return }
        if isFiltering() {
            filteredStrains[indexTapped.row].isFavorite = !hasFavorited
            for index in 0...strains.count - 1 {
                if strains[index].name == filteredStrains[indexTapped.row].name {
                    strains[index].isFavorite = !hasFavorited
                }
            }
            hasFavorited ? removeFromFavorites(thisStrain) : addToFavorites(thisStrain)
            cell.favoritesButton.imageView?.tintColor = hasFavorited ?  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) : .orange
        } else {
            strains[indexTapped.row].isFavorite = !hasFavorited
            hasFavorited ? removeFromFavorites(thisStrain) : addToFavorites(thisStrain)
            cell.favoritesButton.imageView?.tintColor = hasFavorited ? #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) : .orange
        }
        
    }
    
    func removeFromFavorites(_ strain: Product) {
        UserDefaults.standard.deleteProduct(product: strain)
    }
    
    func addToFavorites(_ strain: Product) {
        var listOfProducts = UserDefaults.standard.savedProducts()
        listOfProducts.append(strain)
        let data = NSKeyedArchiver.archivedData(withRootObject: listOfProducts)
        UserDefaults.standard.set(data, forKey: UserDefaults.favoriteKey)
        showBadgeHighlight()
    }
    
    fileprivate func showBadgeHighlight() {
        UIApplication.mainTabBarController()?.viewControllers?[0].tabBarItem.badgeColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        UIApplication.mainTabBarController()?.viewControllers?[0].tabBarItem.badgeValue = "new"
    }
    
    // MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredStrains.count
        }
         return strains.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as StrainsCell = cell else { return }
        if itemHeight[indexPath.row] == closeHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = strainsTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! StrainsCell
        var strain: Product
        cell.delegate = self
        if isFiltering() {
            strain = filteredStrains[indexPath.row]
        } else {
            strain = strains[indexPath.row]
        }
        let savedProducts = UserDefaults.standard.savedProducts()
        let hasFavorited = savedProducts.index(where: { $0.name == strain.name && $0.src == strain.src }) != nil
        if hasFavorited {
            cell.favoritesButton.imageView?.tintColor = .orange
            strain.isFavorite = true
        }
        guard let isFavorite = strain.isFavorite else { return cell }
        cell.favoritesButton.imageView?.tintColor = isFavorite ? .orange : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.setupFoldingCell(strain: strain)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! StrainsCell
        if cell.isAnimating() {
            return
        }
        var duration = 0.0
        if itemHeight[indexPath.row] == closeHeight {
            itemHeight[indexPath.row] = openHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            itemHeight[indexPath.row] = closeHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 1.1
        }
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
}

// MARK: - Protocols
protocol StrainFavoriteDelegate: class {
    func didTapStrainFavoritesButton(in cell: StrainsCell)
}
