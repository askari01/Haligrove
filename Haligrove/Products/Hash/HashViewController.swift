//
//  HashViewController.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-08.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit

class HashViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StrainsViewControllerDelegate {
    
    // MARK: - Property Declarations
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    var hashTableView: UITableView!
    var hashProducts = [Product]()
    
    let closeHeight: CGFloat = 136
    let openHeight: CGFloat = 375
    var rowsCount: Int = 50
    var itemHeight: [CGFloat] = []
    
    let reuseIdentifier = "hashCell"
    let urlString = "http://app.haligrove.com/hashData.json"

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHashTableView()
    }
    
    // MARK: - Class Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        ApiService.shared.fetchJson(from: urlString) { [weak self] (data: [Product]) in
            self?.hashProducts = data
            self?.activityIndicator.stopAnimating()
            self?.hashTableView.reloadData()
        }
    }
    
    func setupHashTableView() {
        navigationItem.title = "Hash"
        hashTableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), style: .plain)
        hashTableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        hashTableView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        hashTableView.dataSource = self
        hashTableView.delegate = self
        hashTableView.separatorStyle = .none
        self.view.addSubview(hashTableView)
        
        self.view.addSubview(activityIndicator)
        self.view.bringSubview(toFront: activityIndicator)
        activityIndicator.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        hashTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.safeAreaLayoutGuide.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
    }
    
    private func setup() {
        itemHeight = Array(repeating: closeHeight, count: rowsCount)
        hashTableView.estimatedRowHeight = closeHeight
        hashTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: - Delegate Methods
    func didTapFavoritesButton(in cell: StrainsFoldingCell) {
        guard let indexTapped = hashTableView.indexPath(for: cell) else { return }
        let thisProduct = hashProducts[indexTapped.row]
        
        guard let hasFavorited = thisProduct.isFavorite else { return }
       
        
        
        hasFavorited ? removeFromFavorites(thisProduct) : addToFavorites(thisProduct)
        cell.favoritesButton.imageView?.tintColor = hasFavorited ?  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) : .orange
    
        hashProducts[indexTapped.row].isFavorite = !hasFavorited
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
        
        listOfProducts.forEach { (product) in
            print(product.name ?? "")
        }
    }
    
    fileprivate func showBadgeHighlight() {
        UIApplication.mainTabBarController()?.viewControllers?[0].tabBarItem.badgeColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        UIApplication.mainTabBarController()?.viewControllers?[0].tabBarItem.badgeValue = "new"
    }


    
    // MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = hashTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}
