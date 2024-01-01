//
//  UserProfileVC.swift
//  TwitterHarsh
//
//  Created by My Mac Mini on 25/12/23.
//

import UIKit
import Combine
import FirebaseAuth
import SDWebImage

class UserProfileVC: UIViewController {

   
    
    var isStatusBarHidden : Bool = true
    
    private var viewModelUserProfile = UserProfileViewModel()
    private var subscriptionsUserProfile: Set<AnyCancellable> = []
    
    var isFromHomeDidSelect : Bool = false
    var strUserIdHome : String = Utils.myUserIDglobal
    
    
    
    //MARK: -  ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: Constants.TVC_TWEET, bundle: nil)
       
        configureCombineView()
        
        
        // adding tap gesture for tap action and show image in ful screen
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(imageProfileTapped))
        headerView.imgProfile.isUserInteractionEnabled = true
        headerView.imgProfile.addGestureRecognizer(pictureTap)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        // show hide follow button according to user - Fire api according to user 
        if isFromHomeDidSelect{
            headerView.btnFollow.isHidden = false
            self.viewModelUserProfile.retreiveUserProfile(userId: strUserIdHome)
 w.isHidden = true
            self.viewModelUserProfile.retreiveUserProfile(userId: Utils.myUserIDglobal)
            headerView.viewBack.isHidden = true
        }
          
         
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
     
    
    private func configureCombineView() {
        viewModelUserProfile.$userProfile.sink { [weak self] user in
            guard let user = user else { return }
            self?.headerView.lblName.text = user.displayName
            self?.headerView.lblId.text = "@\(user.username)"
            self?.headerView.lblFollowers.text = "\(user.followersCount)"
            self?.headerView.lblFollowing.text = "\(user.followingCount)"
         
        }
        .store(in: &subscriptionsUserProfile)
        
        
        viewModelUserProfile.$tweetsProfile.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.tblProfile.reloadData()
            }
        }
        .store(in: &subscriptionsUserProfile)
    }
    
    
    func changeStatusBarColor(){
        if self.traitCollection.userInterfaceStyle == .light {
            self.myStatusBar.backgroundColor = .white
        } else {
            self.myStatusBar.backgroundColor = .black
        }
    
    private func setUpHeaderView(){
        Utils.showLoader(true)
       
        headerView = ProfileHeaderView.instanceFromNib() as! ProfileHeaderView
        headerView.frame = CGRect(x: 0, y: 0, width: DeviceSize.width, height: 540)
        headerView.commonInit()
        self.tblProfile.tableHeaderView = headerView
      
        h
         
        self.myStatusBar.layer.opacity = 0
         
        tblProfile.showsVerticalScrollIndicator = false
        tblProfile.showsHorizontalScrollIndicator = false
        Utils.showLoader(false)
    }
   
    
    fun
    }
     
    //MARK: -  Buttons Actions
    @objc func imageProfileTapped(_ sender: UITapGestureRecognizer) {
        let imgView = sender.view as! UIImageView
        let newImg = UIImageView(image: imgView.image)
        newImg.frame = UIScreen.main.bounds
        newImg.backgroundColor = .black
        newImg.contentMode = .scaleAspectFit
        newImg.isUserInteractionEnabled = true
      self.view.addSubview(newImg) }, completion: nil)
        //self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        //self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
        UIView.transition(with: self.view, duration: 0.35, options: [.transitionCrossDissolve], animations: { sender.view?.removeFromSuperview() }, completion: nil)
    }
 View: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelUserProfile.tweetsProfile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TVC_TWEET, for: indexPath) as? TweetTVC else { return UITableViewCell()}
        
        l
         
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
   
     // show hide status bar put view for change color
    func scrollV 
        }else{
            isStatusBarHidden = true
            UIView.animate(withDuration: 0.1, delay: 0, options : .curveLinear) { [weak self] in
                self?.myStatusBar.layer.opacity = 0
               
            }
        }
    }
    
}
