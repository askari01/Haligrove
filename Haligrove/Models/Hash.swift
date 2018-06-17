//
//  Hash.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-17.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import Foundation

struct Hash: Decodable {
    let id: String
    let name: String
    let src: String
    let isNew: String
    let pricePerGram: Float
    let priceForFive: Float
    let priceForTen: Float
    let sale: String
    let salePricePerGram: Float
    let salePriceForFive: Float
    let salePriceForTen: Float
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
