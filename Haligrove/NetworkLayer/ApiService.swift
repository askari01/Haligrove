//
//  apiService.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-06-07.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit

class ApiService {
    
    static var shared = ApiService()
    
    let strainUrl = "http://app.haligrove.com/strainData.json"
    
    // Fetch Strains from url
    func fetchJSON<T: Decodable>(completion: @escaping ([T]) -> ()) {
        
        guard let url = URL(string: strainUrl) else { return }
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
                    let data = try decoder.decode([T].self, from: data)
                    completion(data)
                } catch let jsonErr {
                    print("Failed: ", jsonErr)
                }
            }

            }.resume()
    }
}
