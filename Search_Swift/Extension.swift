//
//  Extension.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/20.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class Extension {}

extension UIView {
    var safeAreaHeight: CGFloat {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.layoutFrame.size.height
        }
        return bounds.height
    }
}

extension UIImageView {
    func load(url:String,cache:NSCache<NSString, UIImage>) {
        if let image = cache.object(forKey: url as NSString) {
            self.image = image
        } else {
            let imageURL = URL(string: url)
            URLSession.shared.dataTask(with: imageURL!) { data, response, error in
                guard let data = data else {
                    return
                }
                print("image_byte : ", data)
                let image = UIImage(data: data)!
                cache.setObject(image, forKey: url as NSString)
                DispatchQueue.main.async {
                    self.image = image
                }
            }.resume()
        }
    }
}

extension UITableViewCell{
    
    func returnUserRating(rating:Int) -> String {
        var ratingStr = ""
        
        if  1000 <= rating && rating <= 9999 {
            let cheon = rating / 1000
            var bek = rating - (cheon * 1000)
            bek = bek / 100
            ratingStr = "\(cheon).\(bek)천"
        }else if rating >= 10000{
            let man = rating / 10000
            var cheon = rating - (man * 10000)
            cheon = cheon / 1000
            ratingStr = "\(man).\(cheon)만"
        }else{
            ratingStr = "\(rating)"
        }
        
        return ratingStr
    }
    
    func animate() {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseIn, animations: {
            self.contentView.layoutIfNeeded()
        })
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}
