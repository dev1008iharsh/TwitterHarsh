//
//  HomeVC.swift
//  TwitterHarsh
//
//  Created by My Mac Mini  
//

import UIKit
import FirebaseAuth
import Combine
import SDWebImage


class HomeVC: UIViewController {
    
    //MARK: -  @IBOutlet
 
    //MARK: -  Properties
    
    private var leadingConstrains: [NSLayoutConstraint] = []
    
    private var trailingConstrains: [NSLayoutConstraint] = []
    
    private var viewModelHome = HomeViewModel()
    
    private var subscriptionsHome: Set<AnyCancellable> = []
    
    private enum SectonTabs : String{
        case trending = "Trending"
        case fromYou = "From You"
        
        var index: Int {
            
            switch self{
            case .trending :
                return 0
                
            case .fromYou :
  ttomBlueLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .colourTwitterBlue
        return view
    }()
    
    private let tabsBtn : [UIButton] = ["Trending","From You"].map { btnTitle in
        let button = UIButton(type: .system)
        button.setTitle(btnTitle, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    
    private lazy var stackView : UIStackView = {
 
    }()
    
    private var tabSelected: Int = 0 {
        didSet {
            print(tabSelected)
            for i in 0..<tabsBtn.count{
                UIView.animate(withDuration: 0.3, delay: 0,options: .curveEaseInOut) {[weak self] in
                    
                    self?.stackView.arrangedSubviews[i].tintColor = i == self?.tabSelected ? .label : .secondaryLabel
                    
                    self?.leadingConstrains[i].isActive = i == self?.tabSelected ? true : false
                    self?.trailingConstrains[i].isActive = i == self?.tabSelected ? true : false
                    
                    self?.view.layoutIfNeeded()
                    
         
                    
                }
                
            }
        }
    }
    
    
    //MARK: -  ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        let nib = UINib(nibName: Constants.TVC_TWEET, bundle: nil)
        tblHomeFeed.register(nib, forCellReuseIdentifier: Constants.TVC_TWEET)
        
        Utils.heightOfStatusBar = Int(DeviceSize.height)
        //print(Utils.heightOfStatusBar)
        
        configureCombineView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tSubviews()
        configureConstraints()
    }
    
    //MARK: - Helper Functions
    func configureCombineView() {
        viewModelHome.$userHome.sink { [weak self] user in
            
            guard let user = user else { return }
            print(user)
            Utils.myImageUrlGlobal = user.avatarPath
            if !user.isUserOnboarded {
                //self?.completeUserOnboarding()
                self?.presentProfileVC()
            }
        }
       scriptionsHome)
        
    }
    
    
    func presentProfileVC(){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_EDIT_PROFILE, bundle: nil)
        guard let nextVC = storyBoard.instantiateViewController(withIdentifier: Constants.VC_EDIT_PROFILE) as? EditProfileVC else { return }
        nextVC.modalPresentationStyle = .automatic
        nextVC.isModalInPresentation = true
        nextVC.isFromHome = true
        self.navigationController?.present(nextVC, animated: true, completion: nil)
        
    }
    private func handleAuthentication(){
        
     erIDglobal = id
            }
            print("*** Current LoggedIn User :", Utils.myUserIDglobal)
            
            viewModelHome.retreiveCurrentLoggedInUser()
            viewModelHome.fetchAllTweetsByAllUsers()
        }
        
    }
    
    
    
    @objc private func didTapBtns(_ sender : UIButton){
        
        guard let lable = sender.titleLabel?.text else { return }
        switch lable{
        case SectonTabs.trending.rawValue :
            tabSelected = 0
        case SectonTabs.fromYou.rawValue :
            tabSelected = 1
            
        default:
            tabSelected = 0
        }
    }
    
    private func configureConstraints(){
        
        for i in 0..<tabsBtn.count{
            
            let leadingAnchor = bottomBlueLine.leadingAnchor.constraint(equalTo: stackView.arrangedSubviews[i].leadingAnchor, constant: 20)
            leadingConstrains.append(leadingAnchor)
            
            let trailingAnchor = bottomBlueLine.trailingAnchor.constraint(equalTo: stackView.arrangedSubviews[i].trailingAnchor, constant: -20)
            trailingConstrains.append(trailingAnchor)
            
        }
        
        let indicatorConstraints = [
            leadingConstrains[0],
            trailingConstrains[0],
            
            bottomBlueLine.topAnchor.constraint(equalTo: stackView.arrangedSubviews[0].bottomAnchor, constant: -4),
            bottomBlueLine.heightAnchor.constraint(equalToConstant: 4)
        ]
        let sectionConstrain = [
            stackView.leadingAnchor.constraint(equalTo: headerHome.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: headerHome.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: headerHome.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: headerHome.bottomAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(sectionConstrain)
        NSLayoutConstraint.activate(indicatorConstraints)
    }
    
    
    
    func setUpTableView(){
        
        tblHomeFeed.translatesAutoresizingMaskIntoConstraints = false
        tblHomeFeed.addSubview(stackView)
        tblHomeFeed.addSubview(bottomBlueLine)
        tblHomeFeed.tableHeaderView = headerHome
        tblHomeFeed.showsVerticalScrollIndicator = false
        tblHomeFeed.showsHorizontalScrollIndicator = false
        
    }
    
    
    private func setUpStackBtn(){
        for (i,button) in stackView.arrangedSubviews.enumerated(){
            guard let button = button as? UIButton else { return }
            
            if tabSelected == i{
                button.tintColor = .label
            }else{
                button.tintColor = .secondaryLabel
            }
            button.addTarget(self, action: #selector(didTapBtns), for: .touchUpInside)
        }
    }
    
    
    private func configureNavigationBar() {
        
        let size:CGFloat = 36
        let imgLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        imgLogo.contentMode = .scaleAspectFill
        imgLogo.image = UIImage(named: "twitterLogo")
        
        let middleView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        middleView.addSubview(imgLogo)
        navigationItem.titleView = middleView
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(openHarshBanner))
        navigationItem.titleView?.addGestureRecognizer(tapGes)
        
        let logoutImage = UIImage(systemName: "power.circle.fill")
        let rightBtn = UIBarButtonItem(image: logoutImage, style: .plain, target: self, action: #selector(didTapLogout))
        rightBtn.tintColor = .label
        navigationItem.rightBarButtonItem = rightBtn
        navigationItem.leftBarButtonItem?.tintColor = .label
        
        
    }
    
    
    
    //MARK: -  Buttons Actions
    @objc private func openHarshBanner(_ sender: UITapGestureRecognizer) {
        //let imgView = sender.view as! UIImageView
        let newImg = UIImageView(image: UIImage(named: "myBanner"))
        newImg.frame = UIScreen.main.bounds
        newImg.backgroundColor = .black
        newImg.contentMode = .scaleAspectFit
        newImg.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        swipe.direction = [.down,.up]
        newImg.addGestureRecognizer(tap)
        newImg.addGestureRecognizer(swipe)
        
        UIView.transition(with: self.view, duration: 0.35, options: [.transitionCrossDissolve], animations: { self.view.addSubview(newImg) }, completion: nil)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
        UIView.transition(with: self.view, duration: 0.35, options: [.transitionCrossDissolve], animations: { sender.view?.removeFromSuperview() }, completion: nil)
    }
    
    @objc private func didTapLogout() {
        Utils.showConfirmAlert(title: "Logout", message: "Are tou sure you want to logout", view: self) { yesAction in
            
            try? Auth.auth().signOut()
            self.handleAuthentication()
            
        } NoAction: { noAction in }
        
        
    }
    
    
    @IBAction func btnCompose(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_HOME, bundle: nil)
        guard let nextVC = storyBoard.instantiateViewController(withIdentifier: Constants.VC_COMPOSE_TWEET) as? ComposeTweetVC else { return }
        nextVC.modalPresentationStyle = .automatic
        nextVC.isModalInPresentation = false
        
        nextVC.onComposeReturnReload = {
            self.handleAuthentication()
        }
        self.navigationController?.present(nextVC, animated: true, completion: nil)
        
    }
    
    
    
    
}

extension HomeVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelHome.tweetsHome.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TVC_TWEET, for: indexPath) as? TweetTVC else { return UITableViewCell()}
        /*
         cell.imgProfile.image = UIImage(named : "harshProfile")
         cell.lblId.text = "@harsh1008"
         cell.lblName.text = "Harsh Prahlad Darji"
         cell.lblTextTweet.text = "of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
         var tweetModel : Tweet?
         if selectedTab == 0{
         
         }else{
         tweetModel = viewModel.tweets.reversed()[indexPath.row]
         }
         */
        
        let tweetModel = viewModelHome.tweetsHome[indexPath.row]
        cell.configureTweet(with: tweetModel.author.displayName ,
                            username: tweetModel.author.username ,
                            tweetTextContent: tweetModel.tweetContent ,
                            avatarPath: tweetModel.author.avatarPath )
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_PROFILE, bundle: nil)
        guard let nextVC = storyBoard.instantiateViewController(withIdentifier: Constants.VC_USER_PROFILE) as? UserProfileVC else { return }
        //nextVC.lblCatch = txtName.text
        let tweetModel = viewModelHome.tweetsHome[indexPath.row]
        nextVC.strUserIdHome = tweetModel.author.id
        nextVC.isFromHomeDidSelect = true
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
struct DeviceSize {
    static let width:CGFloat = UIScreen.main.bounds.width
    static let height:CGFloat = UIScreen.main.bounds.height
}

extension HomeVC: TableCellButtonsTapProtocol {
    func cellTapReply() {
        print("Reply Clicked")
    }
    
    func cellTapReTweet() {
        print("Retweet Clicked")
    }
    
    func celltapLike() {
        print("Like Clicked")
    }
    
    func cellTapShare() {
        print("Share Clicked")
    }
    
}
