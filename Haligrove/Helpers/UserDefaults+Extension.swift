//
//  UserDefaults+Extension.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-22.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static let favoriteKey = "favoriteKey"
    
    
    func savedProducts() -> [Product] {
        guard let favoriteData = UserDefaults.standard.data(forKey: UserDefaults.favoriteKey) else { return [] }
        guard let favoritedProducts = NSKeyedUnarchiver.unarchiveObject(with: favoriteData) as? [Product] else { return [] }
        return favoritedProducts
    }
    
    func deleteProduct(product: Product) {
        
        let products = savedProducts()
        let filteredProducts = products.filter { (p) -> Bool in
            return p.name != product.name && p.src != product.src
        }
        let data = NSKeyedArchiver.archivedData(withRootObject: filteredProducts)
        UserDefaults.standard.set(data, forKey: UserDefaults.favoriteKey)
        
    }
}
