//
//  Follower.swift
//  TwitterDemo
//
//  Created by Mac on 30/09/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import ObjectMapper

class Follower: NSObject {
    var nextCursor          : Int?
    var nextCursorStr       : Int?
    var previousCursor      : Int?
    var previousCursorStr   : Int?
    var totalCount          : Int?
    var users               : Array<User>?
    
    required convenience init?(map: Map) {
        self.init()
    }
}

extension Follower: Mappable {
    func mapping(map: Map) {
        nextCursor          <- map[DictionaryKeys.nextCursor]
        nextCursorStr       <- map[DictionaryKeys.nextCursorStr]
        previousCursor      <- map[DictionaryKeys.previousCursor]
        previousCursorStr   <- map[DictionaryKeys.previousCursorStr]
        totalCount          <- map[DictionaryKeys.totalCount]
        users               <- map[DictionaryKeys.users]
    }
}

