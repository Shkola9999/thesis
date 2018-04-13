//
//  Extensions.swift
//  MessengerProjectVistula
//
//  Created by Yevhen Shkola on 30.12.2017.
//  Copyright © 2018 Yevhen Shkola. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString: String) {
        self.image = nil

        if let cacheImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cacheImage
            return
        }

        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url! , completionHandler: { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    self.image = downloadedImage
                }
            })
        }).resume()
    }
}
