//
//  FetchJsonFromUrl+Extension.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-13.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import Foundation

extension StrainsViewController {
    func fetchJSON() {
        let urlString = "http://app.haligrove.com/strainData.json"
        guard let url = URL(string: urlString) else { return }
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        
        URLSession(configuration: config).dataTask(with: url) { (data, res, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed: ", err)
                    return
                }
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    self.strains = try decoder.decode([Strain].self, from: data)
                    self.strainsTableView.reloadWithAnimation()
                    self.activityIndicator.stopAnimating()
                } catch let jsonErr {
                    print("Failed: ", jsonErr)
                }
            }
            
            }.resume()
    }
}
