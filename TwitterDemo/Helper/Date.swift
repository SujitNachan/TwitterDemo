//
//  Date.swift
//  TwitterDemo
//
//  Created by Mac on 29/09/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation

extension Date {
    
    func getString(format: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
