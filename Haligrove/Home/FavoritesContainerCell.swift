//
//  FavoritesCell.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-06.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit

class FavoritesContainerCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var favoritesLabel = UILabel()
    private let cellId = "favoritesCell"
    
    let favoritesCellCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFavoriteContainerCellViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupFavoriteContainerCellViews() {
        
        favoritesLabel.font = UIFont.boldSystemFont(ofSize: 24)
        favoritesLabel.textAlignment = .center
       
        backgroundColor = .clear
        favoritesCellCollectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: cellId)
        favoritesCellCollectionView.delegate = self
        favoritesCellCollectionView.dataSource = self
        
        addSubview(favoritesLabel)
        addSubview(favoritesCellCollectionView)
        favoritesCellCollectionView.anchor(top: favoritesLabel.bottomAnchor, right: rightAnchor, bottom: bottomAnchor, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
        favoritesLabel.anchor(top: topAnchor, right: rightAnchor, bottom: favoritesCellCollectionView.topAnchor, left: leftAnchor, paddingTop: 12, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
    }
    
    func setTitleLabel(title: String) {
        favoritesLabel.text = title
    }
    
    // MARK: - CollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FavoritesCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.height, height: frame.height - 60)
    }
}
