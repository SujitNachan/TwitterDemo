//
//  ViewController.swift
//  TwitterDemo
//
//  Created by Mac on 29/09/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import CRNotifications

extension UIViewController {
    
    func showError(title: String, message: String) {
        CRNotifications.showNotification(
            type: CRNotifications.error,
            title: title,
            message: message,
            dismissDelay: 5
        )
    }
    
    func showSuccess(title: String, message: String) {
        CRNotifications.showNotification(
            type: CRNotifications.success,
            title: title,
            message: message,
            dismissDelay: 5
        )
    }
    
    func showInfo(title: String, message: String) {
        CRNotifications.showNotification(
            type: CRNotifications.info,
            title: title,
            message: message,
            dismissDelay: 5
        )
    }
    
    func showActionSheet(
        withTitle title: String?,
        message: String?,
        actions: [UIAlertAction],
        cancelTitle: String = "dismiss"
        ) {
        let alertVC = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .actionSheet
        )
        for action in actions {
            alertVC.addAction(action)
        }
        let cancelAction = UIAlertAction(
            title: NSLocalizedString(
                cancelTitle,
                comment: ""
                ).capitalized,
            style: .cancel
        ) { (action) in
            alertVC.dismiss(
                animated: true,
                completion: nil
            )
        }
        alertVC.addAction(cancelAction)
        
        present(
            alertVC,
            animated: true,
            completion: nil
        )
    }
    
}
