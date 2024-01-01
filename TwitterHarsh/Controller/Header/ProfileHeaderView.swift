//
//  ProfileHeaderView.swift
//  TwitterHarsh
//
//  Created by My Mac Mini on 25/12/23.
//

import UIKit

class ProfileHeaderView: UIView {
    
    @IBOutlet weak var viewStackViewContainer: UIView!
    @IBOutlet weak var backButtonTopConstrain: NSLayoutConstraint!
    : UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblBio: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var imgHeader: UIImageView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var viewBack: UIView!
  utton : (() -> Void)?
    
    
    private enum valueSectionTabs: String {
        case tweets = "Tweets"
        case tweetsAndReplies = "Tweets & Replies"
        case media = "Media"
        case likes = "Likes"
        
        var index: Int {
            switch self {
            case .tweets:
                return 0
            case .tweetsAndReplies:
        
    
    private var leadingConstrains: [NSLayoutConstraint] = []
    private var trailingConstrains: [NSLayoutConstraint] = []
    
    private let bottomBlueLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .colourTwitterBlue
        return view
    }()
    
    private var tabSelected: Int = 0 {
        didSet {
            for i in 0..<btnAllTabs.count {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
                    self?.stackViewTabs.arrangedSubviews[i].tintColor = i == self?.tabSelected ? .label : .secondaryLabel
                    self?.leadingConstrains[i].isActive = i == self?.tabSelected ? true : false
                    self?.trailingConstrains[i].isActive = i == self?.tabSelected ? true : false
                    self?.layoutIfNeeded()
                } completion: { _ in
                    
                }

            }
        }
    }
  
    
    private var btnAllTabs: [UIButton] = ["Tweets", "Tweets & Replies", "Media", "Likes"]
        .map { buttonTitle in
            let button = UIButton(type: .system)
         
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }
    
    private lazy var stackViewTabs: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: btnAllTabs)
        stackView.translatesAutoresizingMaskIntoConstraints = false
     
        stackView.alignment = .center
        return stackView
    }()
    
    private func configureStackButton() {
        for (i, button) in stackViewTabs.arrangedSubviews.enumerated() {
            guard let button = button as? UIButton else { return }
            
            if i == tabSelected {
                button.tintColor = .label
            } else {
         
    
    
    
    @objc private func didTapTab(_ sender: UIButton) {
        guard let label = sender.titleLabel?.text else { return }
        switch label {
        case valueSectionTabs.tweets.rawValue:
            tabSelected = 0
        case valueSectionTabs.tweetsAndReplies.rawValue:
            tabSelected = 1
        case valueSectionTabs.media.rawValue:
            tabSelected = 2
        case valueSectionTabs.likes.rawValue:
            tabSelected = 3
        default:
            tabSelected = 0
        
   public func commonInit() {
       lblFollowers.text = ""
       lblFollowing.text = ""
       lblJoiningDate.text = ""
       lblBday.text = ""
       lblLocation.text = ""
       lblBio.text = ""
       lblId.text = ""
       lblName.text = ""
       imgProfile.image = UIImage(named: "")
       imgHeader.image = UIImage(named: "")
       
       
       viewBack.layer.cornerRadius = viewBack.frame.height/2
       imgProfile.layer.cornerRadius = imgProfile.frame.height/2
       lblBio.translatesAutoresizingMaskIntoConstraints = false
       lblBio.widthAnchor.constraint(equalToConstant: DeviceSize.width - 40).isActive = true
        
       backButtonTopConstrain.constant = Utils.heightOfStatusBar > 800 ? 60 : 30
       
       viewStackViewContainer.addSubview(stackViewTabs)
       viewStackViewContainer.addSubview(bottomBlueLine)
       configureStackButton()
       configConstraints()
       
   }
     
    }
    
     
    private func configConstraints() {
        
        for i in 0..<btnAllTabs.count {
            let leadingAnchor = bottomBlueLine.leadingAnchor.constraint(equalTo: stackViewTabs.arrangedSubviews[i].leadingAnchor)
            leadingConstrains.append(leadingAnchor)
            let trailingAnchor = bottomBlueLine.trailingAnchor.constraint(equalTo: stackViewTabs.arrangedSubviews[i].trailingAnchor)
            trailingConstrains.append(trailingAnchor)
        }
        
        let indicatorConstraints = [
            leadingConstrains[0],
       Constraints = [
            stackViewTabs.leadingAnchor.constraint(equalTo: viewStackViewContainer.leadingAnchor, constant: 0),
            stackViewTabs.trailingAnchor.constraint(equalTo: viewStackViewContainer.trailingAnchor, constant: 0),
            stackViewTabs.topAnchor.constraint(equalTo: viewStackViewContainer.topAnchor, constant: 0),
            stackViewTabs.bottomAnchor.constraint(equalTo: viewStackViewContainer.bottomAnchor, constant: -8),
            stackViewTabs.heightAnchor.constraint(equalToConstant: 40)
             
        ]
        NSLayoutConstraint.activate(indicatorConstraints)
        NSLayoutConstraint.activate(sectionStackConstraints)
        
    }
   
  /*
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
     
    
    
     
    
}
