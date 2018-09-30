//
//  AppHelper.swift
//  TwitterDemo
//
//  Created by Mac on 29/09/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import Alamofire
import KeychainAccess
import SystemConfiguration
import TwitterKit


public class Reachability
{
    class func isConnectedToNetwork() -> Bool
    {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1)
            {   zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false
        {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}



class AppHelper {
    
    private struct Constant {
        static let deviceTokenHeader   = "X-DEVICE-TOKEN"
        static let apiKeyHeader    = "X-AUTH-KEY"
        static let appVersion      = "X-APP-VERSION"
    }
    
    class func getBase64EncodeString() -> String? {
        if let consumerKeyRFC1738 = kConsumerKey.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let consumerSecretRFC1738 = kConsumerSecrete.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
                let concatenateKeyAndSecret = consumerKeyRFC1738 + ":" + consumerSecretRFC1738
                if let secretAndKeyData = concatenateKeyAndSecret.data(using: String.Encoding.ascii, allowLossyConversion: true) {
                    let base64EncodeKeyAndSecret = secretAndKeyData.base64EncodedString(options: NSData.Base64EncodingOptions())
                    return base64EncodeKeyAndSecret
            }
        }
        return nil
    }
    
    class func getCurrentIphoneModel() -> String? {
        let screenMaxLength = max(
            UIScreen.main.bounds.width,
            UIScreen.main.bounds.height
        )
        
        if screenMaxLength == 568.0 {
            return DictionaryKeys.iphone5
        } else if screenMaxLength ==  667.0 {
            return DictionaryKeys.iphone6
        } else if screenMaxLength == 736.0 {
            return DictionaryKeys.iphone6p
        }
        if screenMaxLength == 812 {
            return DictionaryKeys.iphoneX
        }
        return nil
    }
    
    class func getBaseUrl() -> String {
        return "https://api.twitter.com"
    }
    
    class func getHeader()-> HTTPHeaders?{
        if let base64 = getBase64EncodeString() {
            return [
                "Authorization" : "Basic \(base64)" ,
                "Content-Type" : "application/x-www-form-urlencoded;charset=UTF-8"
            ]
        }
        return nil
    }
    
    class func apiBaseUrlString() -> String {
        return AppHelper.getBaseUrl() + "/1.1"
    }
    
    class func getViewController(storyboardId:String) -> UIViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: storyboardId)
    }
    
    class func getCurrentUser() -> User? {
        if let userDict = UserDefaults.standard.value(forKey:"user") as? [String: Any],
            let user = User(JSON: userDict){
            return user
        }
        return nil
    }
    
    class func getUserId() -> Int? {
        return UserDefaults.standard.value(forKey: "USERID") as? Int
    }
    
    class func set(userId: Int) {
        UserDefaults.standard.set(userId, forKey: "USERID")
    }
    
    class func set(currentuser user: User) {
        UserDefaults.standard.set(user.toJSON(),forKey: "user")
        UserDefaults.standard.synchronize()
    }
}

extension AppHelper {
    
    class func getAuthHeaders() -> Dictionary<String, String> {
        var headers = Dictionary<String, String>()
        if let deviceToken = AppHelper.getDeviceToken() {
            headers[Constant.deviceTokenHeader] = deviceToken
        }
        return headers
    }
    
    class func getAuthHeadersWithApiKey() -> Dictionary<String, String> {
        var headers = Dictionary<String, String>()
        if let deviceToken = AppHelper.getDeviceToken(),
            let apiKey = AppHelper.getApiKey(){
            headers[Constant.deviceTokenHeader] = deviceToken
            headers[Constant.apiKeyHeader] = apiKey
        }
        return headers
    }
    
    class func getKeychainServiceName() -> String {
        var serviceName = "Sujit.TwitterDemo.ios.token"
        if let bundleId = Bundle.main.bundleIdentifier {
            serviceName = "\(bundleId)-device-token"
        }
        
        return serviceName
    }
    
    class func setDeviceToken() {
        if let _ = UserDefaults.standard.string(forKey: "device-key") {
            return
        }
        if let key = UIDevice.current.identifierForVendor?.uuidString {
            UserDefaults.standard.set(key, forKey: "device-key")
            UserDefaults.standard.synchronize()
            let keychain = Keychain(service: AppHelper.getKeychainServiceName()).synchronizable(false)
            keychain[AppHelper.getKeychainServiceName()] = key
        }
    }
    
    class func getDeviceToken() -> String? {
        var authKey: String?
        if let _ = UserDefaults.standard.string(forKey: "device-key") {
            let keychain = Keychain(service: AppHelper.getKeychainServiceName())
            authKey = keychain[AppHelper.getKeychainServiceName()]
        }
        return authKey
    }
    
    /*Api key*/
    
    class func getKeychainServiceNameForApiKey() -> String {
        var serviceName = "Sujit.TwitterDemo.ios.token"
        if let bundleId = Bundle.main.bundleIdentifier {
            serviceName = "\(bundleId)-api-key"
        }
        return serviceName
    }
    
    class func setApiKey(authKey: String) {
        UserDefaults.standard.set(AppHelper.getKeychainServiceNameForApiKey(), forKey: "auth-key")
        UserDefaults.standard.synchronize()
        if let key : String = UserDefaults.standard.value(forKey: "auth-key") as? String {
            let keychain = Keychain(service: key)
            keychain[key] = nil
            keychain[key] = authKey
        }
    }
    
    class func getApiKey() -> String? {
        var authKey: String?
        if let key = UserDefaults.standard.string(forKey: "auth-key") {
            let keychain = Keychain(service: key)
            authKey = keychain[key]
        }
        return authKey
    }
}
