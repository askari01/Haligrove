//
//  StrainsViewController.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-08.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit

class StrainsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StrainsViewControllerDelegate {
    
    // MARK: - Property Declarations
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    var strainsTableView: UITableView!
    var strains = [Strain]()
    var filteredStrains = [Strain]()
    
    let closeHeight: CGFloat = 136
    let openHeight: CGFloat = 375
    var rowsCount: Int = 50
    var itemHeight: [CGFloat] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    let reuseIdentifier = "strainCell"
    let urlString = "http://app.haligrove.com/strainData.json"
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setup()
        ApiService.shared.fetchJson(from: urlString) { [weak self] (data: [Strain]) in
            self?.strains = data
            self?.activityIndicator.stopAnimating()
            self?.strainsTableView.reloadWithAnimation()
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
        strainsTableView.register(StrainsFoldingCell.self, forCellReuseIdentifier: reuseIdentifier)
        strainsTableView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        strainsTableView.dataSource = self
        strainsTableView.delegate = self
        strainsTableView.separatorStyle = .none
        self.view.addSubview(strainsTableView)
        
        self.view.addSubview(activityIndicator)
        self.view.bringSubview(toFront: activityIndicator)
        activityIndicator.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        strainsTableView.anchor(top: view.topAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
    }
    
    private func setup() {
        itemHeight = Array(repeating: closeHeight, count: rowsCount)
        strainsTableView.estimatedRowHeight = closeHeight
        strainsTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredStrains = strains.filter({(strain: Strain) -> Bool in
            let doesCategoryMatch = (scope == "All") || (strain.type == scope)
            if searchBarIsEmpty() {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && strain.name.lowercased().contains(searchText.lowercased())
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
    func didTapFavoritesButton(in cell: StrainsFoldingCell) {
        guard let indexTapped = strainsTableView.indexPath(for: cell) else { return }
        
        var theStrain = strains[indexTapped.row]
        if isFiltering() {
           theStrain = filteredStrains[indexTapped.row]
        }
        let hasFavorited = theStrain.isFavorite
        if isFiltering() {
            filteredStrains[indexTapped.row].isFavorite = !hasFavorited
            for index in 0...strains.count - 1 {
                if strains[index].name == filteredStrains[indexTapped.row].name {
                    strains[index].isFavorite = !hasFavorited
                }
            }
            cell.favoritesButton.imageView?.tintColor = hasFavorited ?  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) : .orange
            print(filteredStrains[indexTapped.row].isFavorite)
        } else {
            strains[indexTapped.row].isFavorite = !hasFavorited
            cell.favoritesButton.imageView?.tintColor = hasFavorited ? #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) : .orange
            print(strains[indexTapped.row].isFavorite)
        }
        
    }
    
    // MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredStrains.count
        }
        
        return strains.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as StrainsFoldingCell = cell else { return }
        if itemHeight[indexPath.row] == closeHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! StrainsFoldingCell
        
        var strain: Strain
        cell.delegate = self
        
        if isFiltering() {
            strain = filteredStrains[indexPath.row]
        } else {
            strain = strains[indexPath.row]
        }
        
        cell.favoritesButton.imageView?.tintColor = strain.isFavorite ? .orange : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.setupFoldingCell(strain: strain)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! StrainsFoldingCell
        
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
protocol StrainsViewControllerDelegate: class {
    func didTapFavoritesButton(in cell: StrainsFoldingCell)
}
