/*
 UtilityManager().showAlert(title: "HarshFlix - Harsh Darji", message: "Built Programatically - This application is made by harsh using native swift language, On top of that this app developed without using storyboard with coredata. Backend managed by themoviedb.org and youtube api", view: self)
 */

//  Created by My Mac Mini on 25/12/23.
//


import UIKit
import Combine

class RegisterVC: UIViewController {
    
    //MARK: -  @IBOutlet
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    
    //MARK: -  Properties
    private var viewModelRegister = AuthViewModel()
    
    private var subscriptionsRegister: Set<AnyCancellable> = []
    
    let opacityDisableLayer : Float = 0.3
    
    var onClickRegisterButton : (() -> Void)?
    
    
    //MARK: -  ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLogoToNavigationBarItem(imageName: "twitterLogo", sizeOfImage: 40)
        
        configCombineView()
        
        btnRegister.layer.opacity = opacityDisableLayer
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    private func configCombineView(){
        txtEmail.addTarget(self, action: #selector(didChangeEmailTextField), for: .editingChanged)
        txtPassword.addTarget(self, action: #selector(didChangePasswordTextField), for: .editingChanged)
        
        //$isRegistrationFormValid
        viewModelRegister.$isUserRegistrationFormValid.sink { [weak self] validationState in
            if validationState{
                self?.btnRegister.layer.opacity = 1.0
            }else{
                self?.btnRegister.layer.opacity =  self?.opacityDisableLayer ?? 0.3
            }
        }
        .store(in: &subscriptionsRegister)
        
        //$user
        viewModelRegister.$userAuth.sink { [weak self] user in
            guard user != nil else { return }
            print("**user",user!)
            guard let strongSelf = self else {
                return
            }
            Utils.showAlertHandler(title: "Sucess", message: "An account was successfully created.Enjoy HarshTwitter social media application created by Harsh Darji", view: strongSelf) { action in
                
                
                self?.dismiss(animated: true, completion: {
                    self?.onClickRegisterButton?()
                })
                
                
            }
            
        }
        .store(in: &subscriptionsRegister)
        
        
        viewModelRegister.$errorAuth.sink { [weak self] errorString in
            guard let error = errorString else { return }
            
            guard let strongSelf = self else {
                return
            }
            Utils.showAlert(title: "Eroor", message: error, view: strongSelf)
        }
        .store(in: &subscriptionsRegister)
    }
    
    //MARK: -  Buttons Actions
    @objc func didChangeEmailTextField() {
        viewModelRegister.userEmail = txtEmail.text
        viewModelRegister.validateAuthForm()
        
    }
    @objc func didChangePasswordTextField() {
        viewModelRegister.userPassword = txtPassword.text
        viewModelRegister.validateAuthForm()
    }
    
    @objc func didChangeNameTextField() {
        
        viewModelRegister.validateAuthForm()
    }
    
    @IBAction func btnForgot(_ sender: UIButton) {
        
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        //Password validation With following:- (Password at least eight characters long, one special character, one uppercase, one lower case letter and one digit)
        self.view.endEditing(true)
        if !(Utils.isValidEmail(txtEmail.text ?? "")){
            Utils.showAlert(title: "Invalid email address", message: "Kindly provide a working email address", view: self)
        }else if ((txtPassword?.text ?? "").isValidateSecialPassword == false){
            Utils.showAlert(title: "Invalid password", message: "Minimum 8 characters are required in the password including atleast one special character, one capital letter, one small letter, one upper case, one lower case, and one digit", view: self)
        }else {
            viewModelRegister.createUserRegistration()
        }
        
    }
}

/*
 let storyBoard: UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_HOME, bundle: nil)
 guard let nextVC = storyBoard.instantiateViewController(withIdentifier: Constants.VC_HOME) as? HomeVC else { return }
 let navigationController = self.navigationController!
 navigationController.setViewControllers([nextVC], animated: true)
 
 let storyBoard: UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_HOME, bundle: nil)
 guard let nextVC = storyBoard.instantiateViewController(withIdentifier: Constants.VC_HOME) as? HomeVC else { return }
 //nextVC.lblCatch = txtName.text
 self.navigationController?.pushViewController(nextVC, animated: true)
 */
