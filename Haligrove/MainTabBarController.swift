//
//  ViewController.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-06.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//
// test commit from xcode

import UIKit

class MainTabBarController: UITabBarController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    func setupViewControllers() {
        
        // Home
        let layout = UICollectionViewFlowLayout()
        let homeNavController = templateController(unselectedImage: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "home"), rootViewController: HomeCollectionController(collectionViewLayout: layout))
        
        tabBar.tintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        tabBar.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tabBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        viewControllers = [homeNavController, UIViewController()]
        
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        }
    }
    
    fileprivate func templateController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}

