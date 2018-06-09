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
    
    var strain: Strain?
    
    // foreground cell UI Items
   
    
    // ContainerView UI Items
    
    
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
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.33, 0.26, 0.26]
        return durations[itemIndex]
    }
    
    func set(strain: Strain) {
        //TODO: Setup Cell
        self.strain = strain
    }
    
    func createForegroundView() -> RotatedView {
        
        let foregroundView = RotatedView(frame: .zero)
        foregroundView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        foregroundView.translatesAutoresizingMaskIntoConstraints = false
        foregroundView.layer.cornerRadius = 5
        
        contentView.addSubview(foregroundView)

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
    
    
    
    
    @objc func showStrainInfoView() {
        print("present info view")
    }
    
    @objc func addToCart() {
        print("add to cart button pressed")
        
    }
}
