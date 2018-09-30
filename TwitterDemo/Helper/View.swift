//
//  View.swift
//  TwitterDemo
//
//  Created by Mac on 29/09/18.
//  Copyright © 2018 Mac. All rights reserved.
//
import Foundation
import UIKit

extension UIView {
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(
                width: radius,
                height: radius
            )
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundedCorner(height:CGFloat,color:UIColor)  {
        clipsToBounds = true
        layer.borderColor = color.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = height / 2
    }
    
    func setBorder(color: UIColor, width: CGFloat, cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    func setBottomBorder(color: UIColor, height: CGFloat) {
        let border = CALayer()
        border.frame = CGRect(
            x: 0,
            y: bounds.height - height,
            width:  bounds.width,
            height: height
        )
        border.backgroundColor = color.cgColor
        layer.addSublayer(border)
        border.zPosition = 1
    }
    
    func setTopBorder(color: UIColor, height: CGFloat) {
        let border = CALayer()
        border.frame = CGRect.init(
            x: 0,
            y: 0,
            width: bounds.width,
            height: height
        )
        border.backgroundColor = color.cgColor
        layer.addSublayer(border)
        border.masksToBounds = true
        border.zPosition = 1
    }
    
    func setCornerRadius(radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
    }
    
    func addShadowToView(color:UIColor = UIColor.darkGray) {
        let shadowPath = UIBezierPath(rect: bounds)
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0,height: 0)
        layer.shadowOpacity = 0.6
        //layer.shadowRadius = 8.0
        layer.cornerRadius = 5
        layer.shadowPath = shadowPath.cgPath
        
    }
    
    func constraintsEqualToSuperView(withPadding padding: CGFloat = 0) {
        if let superview = superview {
            NSLayoutConstraint.activate([
                topAnchor.constraint(
                    equalTo: superview.topAnchor,
                    constant: padding
                ),
                bottomAnchor.constraint(
                    equalTo: superview.bottomAnchor,
                    constant: -padding
                ),
                leadingAnchor.constraint(
                    equalTo: superview.leadingAnchor,
                    constant: padding
                ),
                trailingAnchor.constraint(
                    equalTo: superview.trailingAnchor,
                    constant: -padding
                )
            ])
        }
    }

}
