//
//  Constants.swift
//  TwitterDemo
//
//  Created by Mac on 29/09/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation


let kConsumerKey = "Sh4JYw4aQ773emLJTL9zlFFF2"
let kConsumerSecrete = "KYZk6x2O0HO8e1ClUyqDDMjXOnYJhjwHBXrY4PJ6M7OFBxkE7z"

struct DateFormateConstant {
    static let ddMMMyyyy = "dd MMMM yyyy"
    static let MMMddyyyy = "MMM dd,yyyy"
    static let MMMdd = "MMM dd"
    static let ddMMMyy = "dd MMM yy"
    static let MMMyy = "MMM yy"
    static let MMddyyyy = "MM/dd/yyyy"
    static let MMddyy = "MM/dd/yy"
    static let ddMMyyyy = "dd/MM/yyyy"
    static let yyyyMMdd = "yyyy/MM/dd"
    static let hhmma = "hh:mm a"
    static let hhmmaWithoutSpace = "hh:mma"
    static let dateTime = "MM/dd/yyyy hh:mma"
    static let dateTimeWithSpaceInTime = "MM/dd/yyyy hh:mm a"
    static let dateTimeWithSeconds = "yyyy-MM-dd HH:mm:ss"
    static let dayDateYear = "EEEE, MMM d, yyyy"
    static let dateMonthTextYearTime = "dd MMM, yyyy hh:mm a"
    static let dd_MMM_yyyy_hh_mm_a = "dd MMM, yyyy hh:mm a"
    static let dd_MMM_hh_mm_a = "dd MMM hh:mm a"
    static let MMM_dd_yyyy_hh_mm_a = "MMM dd, yyyy hh:mm a"
    static let yyyy_MM_dd_HH_mm = "yyyy-MM-dd HH:mm"
    static let yyyy_MM_dd_HH_mm_ss = "yyyy-MM-dd HH:mm:ss"
    static let yyyy_MM_dd_HH_mm_ss_ZZZ = "yyyy-MM-dd HH:mm:ss ZZZ"
    static let yyyy_MM_dd = "yyyy-MM-dd"
}

struct DictionaryKeys {
    
    static let id               = "id"
    static let success          = "success"
    
    /*image keys*/
    static let original             = "original"
    static let main                 = "main"
    static let thumb                = "thumb"
    static let position             = "position"
    static let isSelected           = "is_selected"
    
    /*iPhone Model*/
    static let iphone5  = "iPhone5"
    static let iphone6  = "iPhone6"
    static let iphone6p = "iPhone6p"
    static let iphoneX  = "iPhoneX"
    
    /*device key*/
    static let deviceKey = "device_token"
    
    /* followerKey */
    static let nextCursor           = "next_cursor"
    static let nextCursorStr        = "next_cursor_str"
    static let previousCursor       = "previous_cursor"
    static let previousCursorStr    = "previous_cursor_str"
    static let totalCount           = "total_count"
    static let users                = "users"
    
    /* user */
    static let createdAt            = "created_at"
    static let location             = "location"
    static let screenName           = "screen_name"
    static let name                 = "name"
    static let favouritesCount      = "favourites_count"
    static let statusesCount        = "statuses_count"
    static let profileImageUrl      = "profile_image_url"
    static let description          = "description"
    static let email                = "email"
    static let friendsCount         = "friends_count"
    static let profileBannerURL     = "profile_banner_url"
    
}







