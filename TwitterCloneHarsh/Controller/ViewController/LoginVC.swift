//
//  LoginVC.swift
//  TwitterCloneHarsh
//
//  Created by My Mac Mini on 25/12/23.
//

import UIKit
import Combine

class LoginVC: UIViewController {
    
    //MARK: -  @IBOutlet
    @IBOutlet weak var constrainLogoTop : NSLayoutConstraint!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnLogin : UIButton!
    
    
    //MARK: -  Properties
    let opacityDisableLayer : Float = 0.3
    
    private var viewModelLogin = AuthViewModel()
    
    private var subscriptionsLogin: Set<AnyCancellable> = []
    
    
    
    
    //MARK: -  ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        constrainLogoTop.constant = view.bounds.height > 800 ? 45 : 10
        configureCombineViews()
        
        btnLogin.layer.opacity = opacityDisableLayer
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
     
    
    private func configureCombineViews(){
        txtEmail.addTarget(self, action: #selector(didChangeEmailTextField), for: .editingChanged)
        txtPassword.addTarget(self, action: #selector(didChangePasswordTextField), for: .editingChanged)
        
        //$isRegistrationFormValid
        viewModelLogin.$isUserRegistrationFormValid.sink { [weak self] validationState in
            
            if validationState{
                self?.btnLogin.layer.opacity = 1.0
            }else{
                self?.btnLogin.layer.opacity = self?.opacityDisableLayer ?? 0.5
            }
        }
        .store(in: &subscriptionsLogin)
        
         
        viewModelLogin.$userAuth.sink { [weak self] user in
            guard user != nil else { return }
            print("**user",user!)
             
            self?.pushToHomeVC(isAnimate: true)
            
        }
        .store(in: &subscriptionsLogin)
        
        viewModelLogin.$errorAuth.sink { [weak self] errorString in
             
            guard let error = errorString else { return }
            
            guard let strongSelf = self else {
                return
            }
            Utils.showAlert(title: "Eroor", message: error, view: strongSelf)
        }
        .store(in: &subscriptionsLogin)
    }
    
    
    func pushToHomeVC(isAnimate : Bool){
        let storyBoard: UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_HOME, bundle: nil)
        guard let nextVC = storyBoard.instantiateViewController(withIdentifier: Constants.VC_HOME) as? HomeVC else { return }
        self.navigationController?.setViewControllers([nextVC], animated: isAnimate)
    }
    
    //MARK: -  Buttons Actions
    @objc func didChangeEmailTextField() {
        viewModelLogin.userEmail = txtEmail.text
        viewModelLogin.validateAuthForm()
        
    }
    @objc func didChangePasswordTextField() {
        viewModelLogin.userPassword = txtPassword.text
        viewModelLogin.validateAuthForm()
    }
    
    @objc func didChangeNameTextField() {
        
        viewModelLogin.validateAuthForm()
    }
    
    
    @IBAction func btnLogin(_ sender: UIButton) {
        
        self.view.endEditing(true)
        if !(Utils.isValidEmail(txtEmail.text ?? "")){
            Utils.showAlert(title: "Invalid email address", message: "Kindly provide a working email address", view: self)
        }else if (txtPassword.text?.count ?? 0) < 8{
            Utils.showAlert(title: "Invalid password", message: "Minimum 8 characters are required in the password", view: self)
        }else{
            viewModelLogin.userLogin()
        }
         
        
    }
    
    
    @IBAction func btnCreatAccount(_ sender: UIButton) {
        self.view.endEditing(true)
        let storyBoard: UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_MAIN, bundle: nil)
        guard let nextVC = storyBoard.instantiateViewController(withIdentifier: Constants.VC_REGISTER) as? RegisterVC else { return }
        nextVC.modalPresentationStyle = .automatic
        nextVC.isModalInPresentation = true
        
        nextVC.onClickRegisterButton = {
            self.pushToHomeVC(isAnimate : false)
        }
        
        self.navigationController?.present(nextVC, animated: true, completion: nil)
      
    }
}


