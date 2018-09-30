//
//  UserData.swift
//  BondApp
//
//  Created by Apple on 7/16/18.
//  Copyright © 2018 Exceptionaire Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

class User: NSObject {
    var id                  : Int?
    var name                : String?
    var screenName          : String?
    var email               : String?
    var desc                : String?
    var createdAt           : String?
    var location            : String?
    var likesCount          : Int?
    var tweetsCount         : Int?
    var followingCount      : Int?
    var profileImageURL     : String?
    var profileBannerImageUrl   : String?
    
    var mainImageUrl : URL? {
        if let url = profileImageURL?.replacingOccurrences(of: "_normal", with: "") {
            return URL(string: url)
        }
        return nil
    }
    
    var thumbImageUrl : URL? {
        if let url = profileImageURL {
            return URL(string: url)
        }
        return nil
    }
    
    var banngerImageUrl : URL? {
        if let url = profileBannerImageUrl {
            return URL(string: url)
        }
        return nil
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
}

extension User: Mappable {
    func mapping(map: Map) {
        id                  <- map[DictionaryKeys.id]
        name                <- map[DictionaryKeys.name]
        screenName          <- map[DictionaryKeys.screenName]
        email               <- map[DictionaryKeys.email]
        desc                <- map[DictionaryKeys.description]
        location            <- map[DictionaryKeys.location]
        createdAt           <- map[DictionaryKeys.createdAt]
        likesCount          <- map[DictionaryKeys.favouritesCount]
        tweetsCount         <- map[DictionaryKeys.statusesCount]
        followingCount      <- map[DictionaryKeys.friendsCount]
        profileImageURL     <- map[DictionaryKeys.profileImageUrl]
        profileBannerImageUrl <- map[DictionaryKeys.profileBannerURL]
    }
}

