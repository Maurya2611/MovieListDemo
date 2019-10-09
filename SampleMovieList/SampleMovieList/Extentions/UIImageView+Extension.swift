//
//  UIImageView+Extension.swift
//  SampleMovieList
//
//  Created by Chandresh on 8/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import Foundation
import UIKit
let imageCache = NSCache<NSString, AnyObject>()
extension UIImageView {
    func addBorder() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red: 222/255.0, green: 225/255.0, blue: 227/255.0, alpha: 1.0).cgColor
    }
    func loadImageUsingCache(withUrl urlString: String) {
        let baseUrl: String = String(format: "https://image.tmdb.org/t/p/w500/%@", urlString)
        if let url = URL(string: baseUrl) {
            DispatchQueue.main.async {
                self.image = nil
            }
            // check cached image
            if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
                DispatchQueue.main.async {
                    self.image = cachedImage
                }
                return
            }
            // if not, download image from url
            URLSession.shared.dataTask(with: url,
                                       completionHandler: { (data, _, error) in
                                        if error != nil {
                                            print(error!)
                                            return
                                        }
                                        DispatchQueue.main.async {
                                            if let image = UIImage(data: data!) {
                                                imageCache.setObject(image, forKey: urlString as NSString)
                                                self.image = image
                                                self.contentMode = .scaleAspectFill

                                            } else {
                                               self.image = #imageLiteral(resourceName: "iconNoImage")
                                               self.contentMode = .scaleAspectFill
                                            }
                                        }
            }).resume()
        }
    }
}
