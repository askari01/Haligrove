//
//  StrainsFoldingCell.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-09.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit
import FoldingCell
import EasyPeasy

class StrainsFoldingCell: FoldingCell, NSCacheDelegate {
    
    // MARK: - Property Declarations
    var strain: Product?
    weak var delegate: StrainsViewControllerDelegate?
    
    // foreground cell UI Items
    var imageContainer = UIImageView()
    var strainNameLabel = UILabel()
    var strainTypeLabel = UILabel()
    var pricePerGramLabel = UILabel()
    var priceOfFiveLabel = UILabel()
    var inventoryBar = UIImageView()
    var saleLabel = UILabel()
    var newLabel = UILabel()
    var favoritesButton = UIButton(type: .custom)
    var isFavorite: Bool?
    
    // ContainerView UI Items
    
    // MARK: - Initializers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        containerView = createContainerView()
        foregroundView = createForegroundView()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Class Methods
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.33, 0.26, 0.26]
        return durations[itemIndex]
    }
    
    func setupFoldingCell(strain: Product) {
        
        self.strain = strain
        
        // Foreground View
        guard let imageSourceString = strain.src else { return }
        imageContainer.loadImageUsingUrlString(urlString: imageSourceString)
        imageContainer.contentMode = .scaleToFill
        imageContainer.layer.cornerRadius = 5
        imageContainer.layer.masksToBounds = true
        
        strainNameLabel.text = strain.name
        strainNameLabel.adjustsFontSizeToFitWidth = true
        strainNameLabel.layer.masksToBounds = true
        strainNameLabel.minimumScaleFactor = 0.2
        strainNameLabel.font = UIFont.boldSystemFont(ofSize: 23)
        strainNameLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        strainNameLabel.numberOfLines = 1
        
        strainTypeLabel.text = strain.type
        strainTypeLabel.font = UIFont.systemFont(ofSize: 16)
        strainTypeLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        guard let pricePerGram = strain.pricePerGram else { return }
        pricePerGramLabel.text = "$\(Int(pricePerGram))/g"
        pricePerGramLabel.font = UIFont.boldSystemFont(ofSize: 26)
        pricePerGramLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        guard let priceFor5 = strain.priceForFive else { return }
        priceOfFiveLabel.text = "5 for $\(Int(priceFor5))"
        priceOfFiveLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        priceOfFiveLabel.font = UIFont.systemFont(ofSize: 14)
        priceOfFiveLabel.numberOfLines = 3
        
        inventoryBar.contentMode = .scaleToFill
        if strain.inventory == "full" {
            inventoryBar.image = #imageLiteral(resourceName: "full")
        }
        if strain.inventory == "threeQuarters" {
            inventoryBar.image = #imageLiteral(resourceName: "threeQuarters")
        }
        if strain.inventory == "med" {
            inventoryBar.image = #imageLiteral(resourceName: "half")
        }
        if strain.inventory == "low" {
            inventoryBar.image = #imageLiteral(resourceName: "oneQuarter")
        }
        
        saleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        saleLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        saleLabel.text = "sale"
        saleLabel.backgroundColor = #colorLiteral(red: 0.6196078431, green: 0.3529411765, blue: 0.8352941176, alpha: 1)
        saleLabel.layer.cornerRadius = 5
        saleLabel.clipsToBounds = true
        if strain.sale == "sale" {
            saleLabel.isHidden = false
        } else {
            saleLabel.isHidden = true
        }
        
        newLabel.font = UIFont.boldSystemFont(ofSize: 14)
        newLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        newLabel.text = "new"
        newLabel.backgroundColor = #colorLiteral(red: 0.9185019135, green: 0.9065433741, blue: 0.3068211675, alpha: 1)
        newLabel.layer.cornerRadius = 5
        newLabel.clipsToBounds = true
        if strain.isNew == "new" {
            newLabel.isHidden = false
        } else {
            newLabel.isHidden = true
        }
        
        let image: UIImage = #imageLiteral(resourceName: "star")
        favoritesButton.setImage(image, for: .normal)
        favoritesButton.addTarget(self, action: #selector(favoritedStrain), for: .touchUpInside)
    }
    
    // TODO: Implement logic for saving favorite strain
    @objc func favoritedStrain() {
        delegate?.didTapFavoritesButton(in: self)
    }
    
    func createForegroundView() -> RotatedView {
        
        let foregroundView = RotatedView(frame: .zero)
        foregroundView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        foregroundView.translatesAutoresizingMaskIntoConstraints = false
        foregroundView.layer.cornerRadius = 5
        
        let inventoryLabel = UILabel()
        inventoryLabel.font = UIFont.systemFont(ofSize: 12)
        inventoryLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        inventoryLabel.text = "inventory"
        
       contentView.addSubview(foregroundView)
        
        foregroundView.addSubview(imageContainer)
        foregroundView.addSubview(strainNameLabel)
        foregroundView.addSubview(strainTypeLabel)
        foregroundView.addSubview(pricePerGramLabel)
        foregroundView.addSubview(priceOfFiveLabel)
        foregroundView.addSubview(inventoryBar)
        foregroundView.addSubview(inventoryLabel)
        foregroundView.addSubview(saleLabel)
        foregroundView.addSubview(newLabel)
        foregroundView.addSubview(favoritesButton)
        
        imageContainer.anchor(top: foregroundView.topAnchor, right: nil, bottom: foregroundView.bottomAnchor, left: foregroundView.leftAnchor, paddingTop: 8, paddingRight: 0, paddingBottom: 8, paddingLeft: 8, width: 120, height: foregroundView.frame.height)
        
        strainNameLabel.anchor(top: imageContainer.topAnchor, right: foregroundView.rightAnchor, bottom: nil, left: imageContainer.rightAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 8, width: 0, height: 0)
        
        strainTypeLabel.anchor(top: strainNameLabel.bottomAnchor, right: nil, bottom: nil, left: imageContainer.rightAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 8, width: 0, height: 0)
        
        pricePerGramLabel.anchor(top: strainTypeLabel.bottomAnchor, right: nil, bottom: nil, left: imageContainer.rightAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 8, width: 0, height: 0)
        
        priceOfFiveLabel.anchor(top: pricePerGramLabel.bottomAnchor, right: nil, bottom: nil, left: pricePerGramLabel.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
        
        inventoryBar.anchor(top: priceOfFiveLabel.bottomAnchor, right: foregroundView.rightAnchor, bottom: imageContainer.bottomAnchor, left: imageContainer.rightAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 9)
        
        inventoryLabel.anchor(top: nil, right: inventoryBar.rightAnchor, bottom: inventoryBar.topAnchor, left: nil, paddingTop: 0, paddingRight: 8, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
        
        newLabel.anchor(top: strainTypeLabel.topAnchor, right: nil, bottom: strainTypeLabel.bottomAnchor, left: strainTypeLabel.rightAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 8, width: 0, height: 0)
        
        saleLabel.anchor(top: strainTypeLabel.topAnchor, right: nil, bottom: strainTypeLabel.bottomAnchor, left: newLabel.rightAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 2, width: 0, height: 0)
        
        favoritesButton.anchor(top: strainNameLabel.bottomAnchor, right: strainNameLabel.rightAnchor, bottom: nil, left: nil, paddingTop: 0, paddingRight: 8, paddingBottom: 0, paddingLeft: 0, width: 30, height: 30)

        foregroundView.easy.layout([
            Height(120),
            Left(8),
            Right(8),
            ])
        
        let top = (foregroundView.easy.layout([Top(8)])).first
        top?.identifier = "ForegroundViewTop"
        self.foregroundViewTop = top
        
        foregroundView.layoutIfNeeded()
        
        return foregroundView
    }

    
    private func createContainerView() -> UIView {
        
        let containerView = UIView(frame: .zero)
        containerView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        itemCount = 3
 
        contentView.addSubview(containerView)

        containerView.easy.layout([
            Height(CGFloat(120 * itemCount)),
            Left(8),
            Right(8),
            ])
        
        let top = (containerView.easy.layout([Top(8)])).first
        top?.identifier = "ContainerViewTop"
        self.containerViewTop = top
        
        containerView.layoutIfNeeded()
        
        return containerView
    }
}
