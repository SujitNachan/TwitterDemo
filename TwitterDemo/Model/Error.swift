//
//  Error.swift
//  TwitterDemo
//
//  Created by Mac on 29/09/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import ObjectMapper

protocol ErrorDelegate: class {
    func didErrorOccur(error: String, statusCode: Int?)
}

class Error: Mappable {
    var msg: String?
    var errorCode : Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        msg          <- map["message"]
        errorCode    <- map["statusCode"]
    }
}

