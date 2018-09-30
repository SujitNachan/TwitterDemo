//
//  FollowingVC.swift
//  TwitterDemo
//
//  Created by Mac on 30/09/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import SVProgressHUD
import KSPhotoBrowser
import XLPagerTabStrip

class FollowingVC: UIViewController {
    
    var itemInfo = IndicatorInfo(title: "Following")
    @IBOutlet fileprivate weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }
    
    fileprivate lazy var followerVM : FollowerVM = {
        return FollowerVM(vc: self)
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startLoading()
        followerVM.fetchFollower(isFollower: false)
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
    
    func updateFollowing() {
        stopLoading()
        tableView.reloadData()
    }
}

extension FollowingVC: UITableViewDataSource, UITableViewDelegate, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followerVM.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "FollowerCell", for: indexPath) as! FollowerCell
        if let user = followerVM.getUser(atIndex: indexPath.row) {
            cell.configureCell(user: user)
            cell.delegate = self
        }
        return cell
    }
}

extension FollowingVC: FollowerCellDelegate {
    func didImageTap(user: User?) {
        let browser = KSPhotoBrowser(
            photoItems: [KSPhotoItem(sourceView: UIImageView(), imageUrl: user?.mainImageUrl)],
            selectedIndex: 0
        )
        browser.show(from: self)
    }
}
