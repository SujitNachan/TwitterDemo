//
//  AttributedText.swift
//  TwitterDemo
//
//  Created by Mac on 29/09/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import UIKit

class AttributedTextComponent {
    let text: String
    let font: UIFont
    let color: UIColor
    
    init(text: String, font: UIFont, color: UIColor) {
        self.text = text
        self.font = font
        self.color = color
    }
}

class AttributedText {
    var components = [AttributedTextComponent]()
    var separator = ""
    
    convenience init(components: [AttributedTextComponent], separator: String) {
        self.init()
        self.components = components
        self.separator = separator
    }
    
    func plainString() -> String {
        return components.map{ $0.text }.joined(separator: separator)
    }
    
    func attributedString() -> NSAttributedString? {
        let plainString = self.plainString()
        let attrStr = NSMutableAttributedString(
            string: plainString
        )
        for component in components {
            attrStr.addAttributes(
                [
                    NSAttributedStringKey.foregroundColor: component.color,
                    NSAttributedStringKey.font: component.font
                ],
                range: (plainString as NSString).range(of: component.text)
            )
        }
        
        return attrStr
    }
    
    func imageAttachedString(forText text: String, imageName: String) -> NSAttributedString {
        let attachment: NSTextAttachment = NSTextAttachment()
        let iconImage = UIImage(named: imageName)
        attachment.image = iconImage
        attachment.bounds = CGRect.init(
            x: 0,
            y: 0,
            width:(iconImage?.size.width)!/2,
            height: (iconImage?.size.width)!/2
        )
        let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)
        let strLabelText: NSAttributedString = NSAttributedString.init(
            string: " " + text,
            attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15),
                         NSAttributedStringKey.baselineOffset: 2]
        )
        let mutableAttachmentString: NSMutableAttributedString = NSMutableAttributedString(
            attributedString: attachmentString
        )
        mutableAttachmentString.append(strLabelText)
        return (mutableAttachmentString)
    }
}
