//
//  Service.swift
//  TestTask
//
//  Created by Vasiliy Matveev on 30.06.2020.
//  Copyright © 2020 Vasiliy Matveev. All rights reserved.
//

import Foundation

class Service {
    
    private init(){}
    static let shared = Service()
    
    let urlString = "https://serpapi.com/search?q=Apple&tbm=isch&ijn=0"
    
    
    func fetchImages(seatchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let err = err {
                print("Failed to load data:", err)
                completion(nil, err)
                return
            }
            
            do {
                guard let data = data else { return }
                let json = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(json, nil)
                
            } catch let err {
                print("Failed to decode data:", err)
                completion(nil, err)
            }
            
        }.resume()
        
    }
    
}
