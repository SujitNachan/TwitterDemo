//
//  FollowerCell.swift
//  TwitterDemo
//
//  Created by Mac on 30/09/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import Kingfisher

protocol FollowerCellDelegate: class {
    func didImageTap(user: User?)
}

class FollowerCell: UITableViewCell {

    static let identifier = "FollowerCell"
    @IBOutlet fileprivate weak var shadowView: UIView!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var follwoerCountLabel: UILabel!
    @IBOutlet fileprivate weak var tweetCountLabel: UILabel!
    @IBOutlet fileprivate weak var userImageView: UIImageView!
    fileprivate var user: User?
    weak var delegate:  FollowerCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImageView.layoutIfNeeded()
        userImageView.setCornerRadius(radius: userImageView.frame.height/2)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageClicked))
        userImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func imageClicked() {
        delegate?.didImageTap(user: user)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowView.layoutIfNeeded()
        shadowView.setNeedsDisplay()
        shadowView.addShadowToView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(user: User) {
        self.user = user
        let name = AttributedTextComponent.init(text: user.name ?? "", font: UIFont.systemFont(ofSize: 15), color: UIColor.black)
        let desc = AttributedTextComponent.init(text: user.desc ?? "", font: UIFont.systemFont(ofSize: 14), color: UIColor.darkGray)
        nameLabel.attributedText = AttributedText.init(components: [name,desc], separator: "\n").attributedString()
        
        let placeHolderFollower = AttributedTextComponent.init(text: "Followers", font: UIFont.systemFont(ofSize: 13), color: UIColor.darkGray)
        let followersCount = AttributedTextComponent.init(text: user.followingCount?.description ?? "", font: UIFont.systemFont(ofSize: 14), color: UIColor.black)
        follwoerCountLabel.attributedText = AttributedText(components: [placeHolderFollower,followersCount], separator: " : ").attributedString()
        
        let placeHolderTweet = AttributedTextComponent.init(text: "Tweets", font: UIFont.systemFont(ofSize: 13), color: UIColor.darkGray)
        let tweetCount = AttributedTextComponent.init(text: user.tweetsCount?.description ?? "", font: UIFont.systemFont(ofSize: 14), color: UIColor.black)
        tweetCountLabel.attributedText = AttributedText(components: [placeHolderTweet,tweetCount], separator: " : ").attributedString()
        userImageView.kf.setImage(with: user.mainImageUrl)
    }

}
