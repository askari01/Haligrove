//
//  FavoritesCell.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-21.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit

class FavoritesCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 15
        self.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
