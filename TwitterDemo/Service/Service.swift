//
//  Service.swift
//  TwitterDemo
//
//  Created by Mac on 29/09/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import TwitterKit


private struct Constant {
    static let followersURL     = AppHelper.apiBaseUrlString()+"/followers/list.json"
    static let followingURL     = AppHelper.apiBaseUrlString()+"/friends/list.json"
    static let creadientialURL  = AppHelper.apiBaseUrlString()+"/account/verify_credentials.json"
}

protocol ServiceDelegate: class {
    func didFetchUser(with user: User?)
    func didFetchFollower(with follower: Follower?)
}

extension ServiceDelegate {
    func didFetchUser(with user: User?){}
    func didFetchFollower(with follower: Follower?){}
}


class Service {
    
    weak var errorDelegate                  : ErrorDelegate?
    weak var delegate                       : ServiceDelegate?
    
    func getCredientials() {
        // Check internet connection
        if(Reachability.isConnectedToNetwork() == false){
            self.errorDelegate?.didErrorOccur(error: "Please check internet connection", statusCode: nil)
            return;
        }
        if let userId = AppHelper.getUserId() {
            let client = TWTRAPIClient(userID: userId.description)
            let req = client.urlRequest(withMethod: "GET", urlString: Constant.creadientialURL, parameters: ["include_email": "true", "skip_status": "true"], error: nil)
            client.sendTwitterRequest(req) { (response, data, error) in
                if let error = error {
                    print("Error: \(error)")
                    self.errorDelegate?.didErrorOccur(error: error.localizedDescription, statusCode: nil)
                }else{
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            print("json: \(json)")
                            
                            if let jsonData = json as? [String:Any],
                                let user = Mapper<User>().map(JSONObject: jsonData)
                            {
                                self.delegate?.didFetchUser(with: user)
                            }
                            
                        } catch let jsonError as NSError {
                            print("json error: \(jsonError.localizedDescription)")
                            self.errorDelegate?.didErrorOccur(error: jsonError.localizedDescription, statusCode: nil)
                        }
                    }else {
                        self.errorDelegate?.didErrorOccur(error: "something went wrong please try again", statusCode: nil)
                    }
                }
            }
        }
    }
    
    //pass false for followings and true for followers default will be follower
    func getUsers(isFollower:Bool = true) {
        // Check internet connection
        if(Reachability.isConnectedToNetwork() == false){
            self.errorDelegate?.didErrorOccur(error: "Please check internet connection", statusCode: nil)
            return;
        }
        
        if let userId = AppHelper.getUserId() {
            // Swift
            // Get the current userID. This value should be managed by the developer but can be retrieved from the TWTRSessionStore.
            let client = TWTRAPIClient()
            let params = ["id": userId.description]
            var clientError : NSError?
            var url = Constant.followingURL
            if isFollower {
               url = Constant.followersURL
            }
            let request = client.urlRequest(withMethod: "GET", urlString: url, parameters: params, error: &clientError)
            client.sendTwitterRequest(request, completion: { (response, data, error) in
                if let error = error {
                    print("Error: \(error)")
                    self.errorDelegate?.didErrorOccur(error: error.localizedDescription, statusCode: nil)
                }else{
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            print("json: \(json)")
                            
                            if let jsonData = json as? [String:Any],
                                let follower = Mapper<Follower>().map(JSONObject: jsonData)
                            {
                                self.delegate?.didFetchFollower(with: follower)
                            }
                            
                        } catch let jsonError as NSError {
                            print("json error: \(jsonError.localizedDescription)")
                            self.errorDelegate?.didErrorOccur(error: jsonError.localizedDescription, statusCode: nil)
                        }
                    }else {
                        self.errorDelegate?.didErrorOccur(error: "something went wrong please try again", statusCode: nil)
                    }
                }
            })
        }else{
            self.errorDelegate?.didErrorOccur(error: "User not found", statusCode: nil)
        }
    }
}
