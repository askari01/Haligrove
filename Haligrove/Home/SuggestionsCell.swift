//
//  SuggestionsCell.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-07-15.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit

class SuggestionsCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
