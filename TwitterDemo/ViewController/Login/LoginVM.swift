//
//  LoginVM.swift
//  TwitterDemo
//
//  Created by Mac on 29/09/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation

class LoginVM {
    
    fileprivate weak var loginVC: LoginVC!
    fileprivate var service = Service()
    fileprivate var user: User?
    init(vc: LoginVC) {
        loginVC = vc
        service.errorDelegate = self
        service.delegate = self
    }
}

extension LoginVM {
    func fetchUserDetails() {
//        service.getUser()
        service.getCredientials()
    }
    
    func getUser() -> User? {
        return user
    }
}

extension LoginVM: ServiceDelegate {
    func didFetchUser(with user: User?) {
        self.user = user
        loginVC.didFetch(user: user)
    }
}

extension LoginVM: ErrorDelegate {
    func didErrorOccur(error: String, statusCode: Int?) {
        loginVC.didErrorOccur(error: error)
    }
}
