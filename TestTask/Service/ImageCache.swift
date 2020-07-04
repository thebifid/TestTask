//
//  ImageCache.swift
//  TestTask
//
//  Created by Vasiliy Matveev on 04.07.2020.
//  Copyright © 2020 Vasiliy Matveev. All rights reserved.
//

import UIKit

class ImageCache {
    
    private init() {}
    static let shared = ImageCache()
    
    var imageCache = NSCache<NSString, UIImage>()
    
    func downloadImage(urlString: String, completion: @escaping (UIImage) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            
            let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, err) in
                
                guard err == nil,
                data != nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                    let `self` = self else {
                        return
                }
                
                guard let image = UIImage(data: data!) else { return }
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            
            dataTask.resume()
            
        }
    } 
}
