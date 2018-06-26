//
//  HashCell.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-25.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit
import FoldingCell

class HashCell: FoldingCell {
    
    var favoritesButton = UIButton(type: .custom)
    var delegate: HashFavoriteDelegate?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupFoldingCell(product: Product) {
        backgroundColor = .black
        let image: UIImage = #imageLiteral(resourceName: "star")
        favoritesButton.setImage(image, for: .normal)
        favoritesButton.addTarget(self, action: #selector(favoritedProduct), for: .touchUpInside)
    }
    
    @objc func favoritedProduct() {
        delegate?.didTapHashFavoritesButton(in: self)
    }
    
}
