//
//  ViewController.swift
//  TwitterDemo
//
//  Created by Mac on 29/09/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import TwitterKit
import KSPhotoBrowser
import SVProgressHUD

class LoginVC: UIViewController {

    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var userImageView: UIImageView!
    @IBOutlet fileprivate weak var friendsButton: UIButton!
    @IBOutlet fileprivate weak var tweetsButton: UIButton!
    @IBOutlet fileprivate weak var likesButton: UIButton!
    @IBOutlet fileprivate weak var bannerImageView: UIImageView!
    
    fileprivate lazy var loginVM : LoginVM = {
        return LoginVM(vc: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
    }
    
    fileprivate func setupUI() {
        userImageView.layoutIfNeeded()
        userImageView.setCornerRadius(radius: userImageView.frame.height/2)
        userImageView.setBorder(color: UIColor.white, width: 5, cornerRadius: userImageView.frame.height/2)
        let tabGesture1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tabGesture1.name = "BannerImageClicked"
        bannerImageView.addGestureRecognizer(tabGesture1)
        let tabGesture2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tabGesture2.name = "ProfileImageClicked"
        userImageView.addGestureRecognizer(tabGesture2)
    }
    
    @objc fileprivate func imageTapped(_ sender: UITapGestureRecognizer) {
        var selectedIndex = 0
        if sender.name == "ProfileImageClicked" {
            selectedIndex = 1
        }
        let browser = KSPhotoBrowser(
            photoItems: [KSPhotoItem(sourceView: UIImageView(), imageUrl: loginVM.getUser()?.banngerImageUrl), KSPhotoItem(sourceView: UIImageView(), imageUrl: loginVM.getUser()?.mainImageUrl)],
            selectedIndex: UInt(selectedIndex)
        )
        browser.show(from: self)
    }
    
    @IBAction fileprivate func friendsButtonClicked() {
        
    }

    fileprivate func loadData() {
        if AppHelper.getUserId() == nil {
            TWTRTwitter.sharedInstance().logIn { (session, error) in
                if let error = error {
                    self.showError(title: "", message: error.localizedDescription)
                }else {
                    if let session = session {
                        // Swift
                        // Get the current userID. This value should be managed by the developer but can be retrieved from the TWTRSessionStore.
                        if let id = Int(session.userID) {
                            AppHelper.set(userId: id)
                            self.startLoading()
                            self.loginVM.fetchUserDetails()
                        }
                    }
                }
            }
        }else {
            startLoading()
            loginVM.fetchUserDetails()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = " "
        navigationController?.isNavigationBarHidden = false
    }
    
    func startLoading() {
        SVProgressHUD.show()
    }
    
    func stopLoading() {
        if SVProgressHUD.isVisible() {
            SVProgressHUD.dismiss()
        }
    }
    
    func didErrorOccur(error: String) {
        stopLoading()
        showError(
            title: "",
            message: error
        )
    }
    
    func didFetch(user: User?) {
        stopLoading()
        if let user = user {
            let name = AttributedTextComponent(text: user.name?.capitalized ?? "", font: UIFont.boldSystemFont(ofSize: 15), color: UIColor.black)
            let screeenName = AttributedTextComponent(text: user.screenName ?? "", font: UIFont.systemFont(ofSize: 14), color: UIColor.darkGray)
            let email = AttributedTextComponent(text: user.email ?? "", font: UIFont.systemFont(ofSize: 14), color: UIColor.darkGray)
            let desc = AttributedTextComponent(text: user.desc ?? "", font: UIFont.systemFont(ofSize: 14), color: UIColor.darkGray)
            let location = AttributedTextComponent(text: user.location ?? "", font: UIFont.systemFont(ofSize: 14), color: UIColor.darkGray)
            
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(attributedString:  AttributedText(components: [name,screeenName,email,desc,location], separator: "\n").attributedString()!)
            // *** Create instance of `NSMutableParagraphStyle`
            let paragraphStyle = NSMutableParagraphStyle()
            // *** set LineSpacing property in points ***
            paragraphStyle.lineSpacing = 4 // Whatever line spacing you want in points
            // *** Apply attribute to string ***
            attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            nameLabel.attributedText = attributedString
            userImageView.kf.setImage(with: user.mainImageUrl)
            bannerImageView.kf.setImage(with: user.banngerImageUrl)
            let tweets = AttributedTextComponent(text: "Tweets", font: UIFont.systemFont(ofSize: 14), color: UIColor.darkGray)
            let tweetsCount = AttributedTextComponent(text: user.tweetsCount?.description ?? "", font: UIFont.systemFont(ofSize: 15), color: UIColor.black)
            tweetsButton.setAttributedTitle(AttributedText(components: [tweets,tweetsCount], separator: "\n").attributedString(), for: .normal)
            tweetsButton.contentHorizontalAlignment = .center
            
            
            let likes = AttributedTextComponent(text: "Likes", font: UIFont.systemFont(ofSize: 14), color: UIColor.darkGray)
            let likesCount = AttributedTextComponent(text: user.likesCount?.description ?? "", font: UIFont.systemFont(ofSize: 15), color: UIColor.black)
            likesButton.setAttributedTitle(AttributedText(components: [likes,likesCount], separator: "\n").attributedString(), for: .normal)
            likesButton.contentHorizontalAlignment = .center
            likesButton.contentVerticalAlignment = .center
            let friends = AttributedTextComponent(text: "Friends", font: UIFont.systemFont(ofSize: 14), color: UIColor.darkGray)
            let count = AttributedTextComponent(text: user.followingCount?.description ?? "", font: UIFont.systemFont(ofSize: 15), color: UIColor.black)
            friendsButton.setAttributedTitle(AttributedText(components: [friends,count], separator: "\n").attributedString(), for: .normal)
            friendsButton.contentHorizontalAlignment = .center
            friendsButton.contentVerticalAlignment = .center
            
        }
    }

}

