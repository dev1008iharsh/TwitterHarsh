//
//  TweetTVC.swift
//  TwitterCloneHarsh
//
//  Created by My Mac Mini on 25/12/23.
//

import UIKit

protocol TableCellButtonsTapProtocol: AnyObject {
    func cellTapReply()
    func cellTapReTweet()
    func celltapLike()
    func cellTapShare()
}

class TweetTVC: UITableViewCell {
    
    //MARK: -  @IBOutlet
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblTextTweet: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRetweet: UILabel!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnReTweet: UIButton!
    @IBOutlet weak var btnReply: UIButton!
    
    //MARK: -  Properties
    weak var delegate: TableCellButtonsTapProtocol?
    
    
    //MARK: -  ViewController LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //make circle
        imgProfile.layer.cornerRadius = imgProfile.frame.height/2
        
    }
    
    //MARK: - Helper Functions
    func configureTweet(with displayName: String, username: String, tweetTextContent: String, avatarPath: String) {
        lblName.text = displayName
        lblId.text = "@\(username)"
        lblTextTweet.text = tweetTextContent
        imgProfile.sd_setImage(with: URL(string: avatarPath))
    }
    private func configureButtons() {
        btnReply.addTarget(self, action: #selector(didTapReply), for: .touchUpInside)
        btnReTweet.addTarget(self, action: #selector(didTapRetweet), for: .touchUpInside)
        btnLike.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        btnShare.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
    }
    
    
    //MARK: -  Buttons Actions
    @objc private func didTapReply() {
        delegate?.cellTapReply()
    }
    
    @objc private func didTapRetweet() {
        delegate?.cellTapReTweet()
    }
    
    @objc private func didTapLike() {
        delegate?.celltapLike()
    }
    
    @objc private func didTapShare() {
        delegate?.cellTapShare()
    }
 
}
