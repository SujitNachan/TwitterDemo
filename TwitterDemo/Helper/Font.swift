//
//  Font.swift
//  TwitterDemo
//
//  Created by Mac on 29/09/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    class func regular(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: "SF-Pro-Display-Regular", size: size) {
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }
    
    class func medium(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: "SF-Pro-Display-Medium", size: size) {
            return font
        }
        return UIFont.systemFont(
            ofSize: size,
            weight: UIFont.Weight.medium
        )
    }
    
    class func thin(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(
            ofSize: size,
            weight: UIFont.Weight.thin
        )
    }
    
    class func semiBold(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: "SF-Pro-Display-Semibold", size: size) {
            return font
        }
        return UIFont.systemFont(
            ofSize: size,
            weight: UIFont.Weight.semibold
        )
    }
    
    class func bold(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(
            ofSize: size,
            weight: UIFont.Weight.bold
        )
    }
    
    class func heavy(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(
            ofSize: size,
            weight: UIFont.Weight.heavy
        )
    }
    
    class func regularFontBaseOnDevice(_ size: CGFloat) -> UIFont {
        if AppHelper.getCurrentIphoneModel() == DictionaryKeys.iphone5 {
            return UIFont.systemFont(ofSize: size - 2)
        }
        return UIFont.systemFont(ofSize: size)
    }
}
