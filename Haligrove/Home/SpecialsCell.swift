//
//  SpecialsCell.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-07-15.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit

// TODO: - Refactor into a template cell
class SpecialsCell: UICollectionViewCell {
    
    // MARK: - Property Declarations
    var cellImageView = CustomCacheImageView()
    // TODO: - Make custom labels for specials with id and salePriceForFive
    var nameLabel = UILabel()
    var salePriceLabel = UILabel()
    
    var product: Product! {
        didSet {
            cellImageView.loadImageUsingUrlString(urlString: product.src ?? "")
            nameLabel.text = product.name
            salePriceLabel.text = "\(product.id ?? "5") for $\(Int(product.salePriceForFive ?? 0))"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Methods
    private func setupCell() {
        self.layer.cornerRadius = 15
        self.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cellImageView.contentMode = .scaleToFill
        cellImageView.layer.cornerRadius = 15
        cellImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cellImageView.layer.masksToBounds = true
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        salePriceLabel.font = UIFont.systemFont(ofSize: 18)
        salePriceLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        salePriceLabel.textAlignment = .center
    }
    
    private func layoutViews() {
        addSubview(cellImageView)
        cellImageView.anchor(top: topAnchor, right: rightAnchor, bottom: nil, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
        cellImageView.heightAnchor.constraint(equalTo: cellImageView.widthAnchor).isActive = true
        
        addSubview(nameLabel)
        nameLabel.anchor(top: cellImageView.bottomAnchor, right: cellImageView.rightAnchor, bottom: nil, left: cellImageView.leftAnchor, paddingTop: 8, paddingRight: 0, paddingBottom: 0, paddingLeft: 8, width: 0, height: 0)
        
        addSubview(salePriceLabel)
        salePriceLabel.anchor(top: nameLabel.bottomAnchor, right: rightAnchor, bottom: nil, left: leftAnchor, paddingTop: 8, paddingRight: 8, paddingBottom: 0, paddingLeft: 8, width: 0, height: 0)
       
    }
}
