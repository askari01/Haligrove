//
//  NewArrivalsCell.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-07-15.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit

// TODO: - Refactor into a template cell
class NewArrivalsCell: UICollectionViewCell {
    
    // MARK: - Property Declarations
    var cellImageView = CustomCacheImageView()
    var nameLabel = UILabel()
    var singlePrice = UILabel()
    var typeLabel = UILabel()
    var for5Label = UILabel()
    
    var product: Product! {
        didSet {
            cellImageView.loadImageUsingUrlString(urlString: product.src ?? "")
            nameLabel.text = product.name
            singlePrice.text = "$\(Int(product.pricePerGram ?? 0.00))"
            typeLabel.text = "\(product.type ?? product.category ?? "")"
            for5Label.text = "5 for $\(Int(product.priceForFive ?? 0.00))"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
