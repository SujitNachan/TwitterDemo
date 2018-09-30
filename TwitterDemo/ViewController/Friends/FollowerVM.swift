//
//  FollowerVM.swift
//  TwitterDemo
//
//  Created by Mac on 30/09/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
class FollowerVM {
    
    fileprivate weak var followerVC: FollowerVC?
    fileprivate weak var followingVC: FollowingVC?
    fileprivate var service = Service()
    fileprivate var followers = [User]()
    fileprivate var cusror = -1
    init(vc: FollowerVC) {
        followerVC = vc
        service.errorDelegate = self
        service.delegate = self
    }
    
    init(vc: FollowingVC) {
        followingVC = vc
        service.errorDelegate = self
        service.delegate = self
    }
}

extension FollowerVM {
    func fetchFollower(isFollower: Bool = true) {
        service.getUsers(isFollower: isFollower)
    }
    
    func numberOfRows() -> Int {
        return followers.count
    }
    
    func getUser(atIndex index: Int) -> User? {
        if index < followers.count {
            return followers[index]
        }
        return nil
    }
}

extension FollowerVM: ServiceDelegate {
    func didFetchFollower(with follower: Follower?) {
        if let users = follower?.users {
            followers = users
        }
        followerVC?.updateFollower()
        followingVC?.updateFollowing()
    }
}

extension FollowerVM: ErrorDelegate {
    func didErrorOccur(error: String, statusCode: Int?) {
        followerVC?.didErrorOccur(error: error)
        followingVC?.didErrorOccur(error: error)
    }
}
