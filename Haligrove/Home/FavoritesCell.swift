//
//  FavoritesCell.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-06.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit

class FavoritesCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFavoriteCellViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupFavoriteCellViews() {
        backgroundColor = .black
    }
}
