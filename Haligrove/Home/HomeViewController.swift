//
//  HomeViewController.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-06.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Property Declarations
    let homeFavoritesCellIdentifier = "favoritesCell"
    
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
    
    private func homeViewSetup() {
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.tintColor = .gray
        navigationController?.navigationBar.barStyle = .black
        
        favoritesCollectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: homeFavoritesCellIdentifier)
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
    }
    
    // MARK: - Class Methods
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
    
    // MARK: - CollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoritesCollectionView.dequeueReusableCell(withReuseIdentifier: homeFavoritesCellIdentifier, for: indexPath) as! FavoritesCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (containerView.frame.width / 2) - 12 , height: containerView.frame.height * 0.90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
   
}














