//
//  UIColorHelper.swift
//  TwitterDemo
//
//  Created by Mac on 29/09/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func from(hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class func appLightGrayColor() -> UIColor {
        return UIColor.from(hex: "#F6F6F6")
    }
    class func appRedColor() -> UIColor{
        
        return UIColor.from(hex: "#C44B4B")
    }
    class func primary() -> UIColor {
        return UIColor.from(hex: "#555555")
    }
    
    class func appCyan() -> UIColor {
        return UIColor.from(hex: "#29B7C7")
    }
    
    class func appDarkCyan() -> UIColor {
        guard let darkCyan = UIColor.appCyan().darker() else {
            return UIColor.appCyan()
        }
        
        return darkCyan
    }
    
    class func backgroundShadowColor() -> UIColor{
        return UIColor(displayP3Red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
    }
    
    class func startupBackgroundColor () -> UIColor {
        return UIColor(red: 51/255, green: 62/255, blue: 80/255, alpha: 1)
    }
    class func appLinkColor() -> UIColor {
        return UIColor.from(hex: "#386E95")
    }
    
    class func darkPrimaryColor() -> UIColor {
        return UIColor.from(hex: "#555555")
    }
    
    class func accent() -> UIColor {
        return UIColor.from(hex: "#edc789")
    }
    
    class func appGray() -> UIColor {
        return UIColor.from(hex: "#9e9e9e")
    }
    
    class func appBorderColor() -> UIColor{
        return UIColor.from(hex: "#BBBBBB")
    }
    class func navBar() -> UIColor {
        return UIColor.from(hex: "#303030")
    }
    
    class func background() -> UIColor {
        return UIColor.from(hex: "#fbfbfb")
    }
    
    
    func lighter(by percentage:CGFloat=30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage:CGFloat=30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage:CGFloat=30.0) -> UIColor? {
        var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0;
        if(self.getRed(&r, green: &g, blue: &b, alpha: &a)){
            return UIColor(red: min(r + percentage/100, 1.0),
                           green: min(g + percentage/100, 1.0),
                           blue: min(b + percentage/100, 1.0),
                           alpha: a)
        }else{
            return nil
        }
    }
}
