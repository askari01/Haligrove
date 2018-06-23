//
//  MainTabBar+Extension.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-22.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit

extension UIApplication {
    static func mainTabBarController() -> MainTabBarController? {
        return shared.keyWindow?.rootViewController as? MainTabBarController
    }
}
