//
//  Strain.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-06.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import Foundation

enum StrainType: String {
    case indica = "Indica"
    case sativa = "Sativa"
    case hybrid = "Hybrid"
}

struct Strain: Decodable {
    let id: String
    let name: String
    let src: String
    let type: String
    let isNew: String
    let pricePerGram: Float
    let priceForFive: Float
    let pricePerOunce: Float
    let sale: String
    let salePricePerGram: Float
    let salePriceForFive: Float
    let salePricePerOunce: Float
    let description: String
    let inventory: String
    let THC: Int
    let taste: Int
    let aroma: Int
    let pain: Int
    let insomnia: Int
    let appetite: Int
    let overall: Int
    let soldOut: String
    
    var isFavorite: Bool
}
