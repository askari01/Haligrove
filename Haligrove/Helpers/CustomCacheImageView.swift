//
//  LoadImageFromUrl+Cache+Extension.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-07.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, UIImage>()

class CustomCacheImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        imageUrlString = urlString
        guard let url = URL(string: urlString) else { return }
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) {
            self.image = imageFromCache
            return
        }
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if err != nil {
                print("Could not download image data: ", err ?? "")
                return
            }
            DispatchQueue.main.async {
                guard let data = data else { return }
                guard let imageToCache = UIImage(data: data) else { return }
                if self.imageUrlString == urlString {
                   self.image = imageToCache
                }
                imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                
            }
        }.resume()
    }
}


