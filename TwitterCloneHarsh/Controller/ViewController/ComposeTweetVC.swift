//
//  ComposeTweetVC.swift
//  TwitterCloneHarsh
//
//  Created by My Mac Mini on 26/12/23.
//

import UIKit
import Combine

class ComposeTweetVC: UIViewController{
    //MARK: -  @IBOutlet
    @IBOutlet weak var txtvTweetContent: UITextView!
    
    @IBOutlet weak var btnPost: UIButton!
    
    @IBOutlet weak var imgUserProfile : UIImageView!
    
    @IBOutlet weak var lblCounter: UILabel!
    
    @IBOutlet weak var lblPlaceHolder: UILabel!
    
    
    //MARK: -  Properties
    private var viewModelComposeTweet = ComposeTweetViewModel()
    private var subscriptionsComposeTweet: Set<AnyCancellable> = []
    
    let opacityDisableLayer : Float = 0.3
    var totalAllowedCharacters = 600
  
    var onComposeReturnReload : (() -> Void)?
    var trendingHashTagFromSearch = ""
    
    
    //MARK: -  ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnPost.layer.opacity = opacityDisableLayer
        txtvTweetContent.delegate = self
        lblCounter.isHidden = true
        btnPost.layer.cornerRadius = btnPost.frame.height/2
        
        if !(trendingHashTagFromSearch == ""){
            lblPlaceHolder.isHidden = true
            txtvTweetContent.text = trendingHashTagFromSearch
        }else{
            lblPlaceHolder.isHidden = false
        }
        
        imgUserProfile.layer.cornerRadius = imgUserProfile.frame.height/2
        imgUserProfile.sd_setImage(with: URL(string: Utils.myImageUrlGlobal))
        configureCombineView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        viewModelComposeTweet.getUserData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - Helper Functions
    private func configureCombineView() {
         
        
        viewModelComposeTweet.$isValidToTweet.sink { [weak self] state in
             
            if state{
                self?.btnPost.layer.opacity = 1.0
            }else{
                self?.btnPost.layer.opacity =  self?.opacityDisableLayer ?? 0.3
            }
        } .store(in: &subscriptionsComposeTweet)
        
        viewModelComposeTweet.$shouldDismissComposer.sink { [weak self] success in
            if success {
                self?.dismiss(animated: true)
                self?.onComposeReturnReload?()
            }
        }
        .store(in: &subscriptionsComposeTweet)
        
        
    }
     
   
    //MARK: -  Buttons Actions
    @IBAction func btnPost(_ sender: UIButton) {
        self.view.endEditing(true)
        if txtvTweetContent.text.count < 100{
            UtilityManager().showAlert(title: "Tweet content is too short", message: "It has to be minimum 100 characters", view: self)
        }else{
           // create tweet post
            viewModelComposeTweet.dispatchTweet()
        }
    }
    
    @IBAction func btnCancle(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

//MARK: -  UITextViewDelegate
extension ComposeTweetVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        lblPlaceHolder.isHidden = true
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(textView.text.count != 0) {
            lblPlaceHolder.isHidden = true
        }
        else {
            lblPlaceHolder.isHidden = false
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        if numberOfChars > 5 {
            lblCounter.isHidden = false
        }else{
            lblCounter.isHidden = true
        }
        
        lblCounter.text = "(\(totalAllowedCharacters - numberOfChars)/\(totalAllowedCharacters))"
        return numberOfChars < totalAllowedCharacters
    }
    func textViewDidChange(_ textView: UITextView) {
        viewModelComposeTweet.tweetContent = textView.text
        viewModelComposeTweet.validateToTweet()
    }
    
}
