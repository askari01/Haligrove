//
//  HomeViewController.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-06.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Property Declarations
    var favoritedProducts = UserDefaults.standard.savedProducts()
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate let homeFavoritesCellIdentifier = "favoritesCell"
    
    let homeFavoritesLabel: UILabel = {
       let label = UILabel()
        label.text = "Favorites"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    let containerView: UIView = {
        let cv = UIView()
        cv.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return cv
    }()
    
    let favoritesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.indicatorStyle = .white
        return cv
    }()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewSetup()
        layoutViews()
    }
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritedProducts = UserDefaults.standard.savedProducts()
        favoritesCollectionView.reloadData()
        UIApplication.mainTabBarController()?.viewControllers?[0].tabBarItem.badgeValue = nil
    }
    
    // MARK: - Class Methods
    private func homeViewSetup() {
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.tintColor = .gray
        navigationController?.navigationBar.barStyle = .black
        favoritesCollectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: homeFavoritesCellIdentifier)
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        favoritesCollectionView.addGestureRecognizer(gesture)
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: favoritesCollectionView)
        guard let selectedIndexPath = favoritesCollectionView.indexPathForItem(at: location) else { return }
        let alertController = UIAlertController(title: "Remove Product from Favorites?", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
            let selectedProduct = self.favoritedProducts[selectedIndexPath.item]
            self.favoritedProducts.remove(at: selectedIndexPath.item)
            self.favoritesCollectionView.deleteItems(at: [selectedIndexPath])
            UserDefaults.standard.deleteProduct(product: selectedProduct)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
    
    private func layoutViews() {
        // Favorites Label
        view.addSubview(homeFavoritesLabel)
        homeFavoritesLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.safeAreaLayoutGuide.rightAnchor, bottom: nil, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: 12, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: view.frame.width, height: 50)
        
        // ContainerView + CollectionView
        view.addSubview(containerView)
        containerView.anchor(top: homeFavoritesLabel.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, bottom: nil, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: view.frame.width, height: 280)
        
        containerView.addSubview(favoritesCollectionView)
        favoritesCollectionView.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, right: containerView.safeAreaLayoutGuide.rightAnchor, bottom: containerView.safeAreaLayoutGuide.bottomAnchor, left: containerView.safeAreaLayoutGuide.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        favoritesCollectionView.reloadData()
    }
    
    // MARK: - CollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritedProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoritesCollectionView.dequeueReusableCell(withReuseIdentifier: homeFavoritesCellIdentifier, for: indexPath) as! FavoritesCell
        cell.product = self.favoritedProducts[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (containerView.frame.width - 3 * 8) / 2
        let height = containerView.frame.height * 0.90
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
   
}
