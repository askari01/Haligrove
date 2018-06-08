//
//  HomeCollectionController.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-06.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeCollectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewSetup()
    }
    
    private func homeViewSetup() {
        
        self.collectionView!.register(FavoritesContainerCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView?.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.tintColor = .gray
        navigationController?.navigationBar.barStyle = .black
       
    }
    
    // MARK:- UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FavoritesContainerCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}














