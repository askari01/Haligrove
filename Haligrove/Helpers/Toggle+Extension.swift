//
//  Toggle+Extension.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-12.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import Foundation

extension Bool {
    mutating func toggle() {
        self = !self
    }
}
