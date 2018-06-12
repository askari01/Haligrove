//
//  StrainsViewController.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-08.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit

class StrainsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Property Declarations
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    var strains = [Strain]()
    var filteredStrains = [Strain]()
    
    let closeHeight: CGFloat = 136
    let openHeight: CGFloat = 375
    var rowsCount: Int = 50
    var itemHeight: [CGFloat] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    private var strainsTableView: UITableView!
    let reuseIdentifier = "strainCell"
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJSON()
        setupTableView()
        setup()
    }
    
    // MARK: - Class Methods
    fileprivate func fetchJSON() {
        let urlString = "http://app.haligrove.com/strainData.json"
        guard let url = URL(string: urlString) else { return }
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        
        URLSession(configuration: config).dataTask(with: url) { (data, res, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed: ", err)
                    return
                }
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    self.strains = try decoder.decode([Strain].self, from: data)
                    self.strainsTableView.reloadWithAnimation()
                    self.activityIndicator.stopAnimating()
                } catch let jsonErr {
                    print("Failed: ", jsonErr)
                }
            }
            
            }.resume()
    }
    
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
        
        let strain: Strain
        
        if isFiltering() {
            strain = filteredStrains[indexPath.row]
        } else {
            strain = strains[indexPath.row]
        }
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
