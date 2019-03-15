//
//  Extensions.swift
//  youtube
//
//  Created by Khalal Walker on 3/11/19.
//  Copyright © 2019 Khalal Walker. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: format, metrics: nil, views: viewsDictionary))
    }
}



class CustomImageView: UIImageView {
    let imageCache = NSCache<AnyObject, AnyObject>()
    var imageUrlString: String = ""
    
    func loadImageUsingURLString(urlString: String) {
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                if self.imageUrlString == urlString {
                    self.imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                }
                
                
                
                self.image = UIImage(data: data!)
            }
            
            }.resume()
    }
}

