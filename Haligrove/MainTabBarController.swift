//
//  ViewController.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-06.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    //TODO: - reconstruct each navController without default controller
    func setupViewControllers() {
        
        // Home
        let homeNavController = templateController(for: HomeCollectionController(collectionViewLayout: UICollectionViewFlowLayout()), title: "Home", image: #imageLiteral(resourceName: "home"))
        
        // Products
        let productsNavController = templateController(for: ProductsCollectionController(collectionViewLayout: UICollectionViewFlowLayout()), title: "Products", image: #imageLiteral(resourceName: "strains"))
        
        // Info
        let infoNavController = templateController(title: "Info", image: #imageLiteral(resourceName: "about"))
        
        // Sales
        let salesNavController = templateController(title: "Sales", image: #imageLiteral(resourceName: "money"))
        
        // Cart
        let cartNavController = templateController(title: "Cart", image: #imageLiteral(resourceName: "shopping_cart"))
        
        tabBar.tintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        tabBar.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tabBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        viewControllers = [homeNavController, productsNavController, infoNavController, salesNavController, cartNavController]
        
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        }
    }
    
    fileprivate func templateController(for rootViewController: UIViewController = UIViewController(), title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}

