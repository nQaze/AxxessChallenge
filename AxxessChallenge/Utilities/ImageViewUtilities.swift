//
//  ImageViewUtilities.swift
//  AxxessChallenge
//
//  Created by Nabil Kazi on 14/07/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func loadImageUsingCache(withUrl urlString: String, defaultImage : UIImage?) {
        let url = URL(string: urlString)
        self.image = nil
        
        // Check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // If not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, _, error) in
            if error != nil {
                print(error!)
                performUIUpdatesOnMain {
                    if let defaultImage = defaultImage {
                        self.image = defaultImage
                    }
                }
                return
            }
            
            performUIUpdatesOnMain {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
            
        }).resume()
    }
    
}
