//
//  EditProfileVC.swift
//  TwitterHarsh
//
//  Created by My Mac Mini  
//

import UIKit
import YPImagePicker
import Combine
import SDWebImage

class EditProfileVC: UIViewController {

    //MARK: -  @IBOutlet
    @  txtUsername: UITextField!
    
    @IBOutlet weak var txtBirthdate: UITextField!
    
    @IBOutlet weak var txtLocation: UITextField!
    
    @IBOutlet weak var txtVBio: UITextView!
    
    @IBOutlet weak var imgCoverHeader: UIImageView!
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lblEditProfileAndCounter: UILabel!
    
    @IBOutlet weak var imgDummyCoverCamera: UIImageView!
    
    @IBOutlet weak var imgDummyProfileCamera: UIImageView!
    
    
    //MARK: -  Properties
    private let viewModelEditProfile = EditProfileViewModel()
    
    private var subscriptionsEditProfile: Set<AnyCancellable> = []
     
    let opacityDisableLayer : Float = 0.3
      
    //MARK: -  ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
         
        setUpScreen()
        configureCombineViews()
          
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
        if (self.isFromHome){
            self.btnCancle.isHidden = false
            btnSave.layer.opacity = opacityDisableLayer
           
        }else{
            self.btnCancle.isHidden = true
  
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - Helper Functions
    func setUpScreen(){
 
        // checking is it opening first time when ussed logged in first time
        if isFromHome{
            txtName.text = ""
            txtUsername.text = ""
            txtBirthdate.text = ""
            txtLocation.text = ""
            txtVBio.text = "Tell the world about yourself"
            txtVBio.textColor = appColor.ColourPlaceHolder
            imgCoverHeader.image = UIImage(named: "")
            imgProfile.image = UIImage(named: "")
 a.isHidden = true
        }
        
        imgProfile.layer.cornerRadius = imgProfile.frame.height/2
        imgProfile.layer.borderWidth = 1
        imgProfile.layer.borderColor = UIColor.colourTwitterBlue.cgColor
     
        txtVBio.delegate = self
        txtName.delegate = self
        txtUsername.delegate = self
        txtBirthdate.delegate = self
        txtLocation.delegate = self
        
        txtName.addTarget(self, action: #selector(didUpdateDisplayName), for: .editingChanged)
        txtUsername.addTarget(self, action: #selector(didUpdateUsername), for: .editingChanged)
        txtBirthdate.addTarget(self, action: #selector(didUpdateBdate), for: .editingChanged)
        txtLocation.addTarget(self, action: #selector(didUpdateLocation), for: .editingChanged)
        
        self.setDatePicker()
     
        
    }
     
    private func configureCombineViews() {
        if !isFromHome{
            
            viewModelEditProfile.$userEditProfile.sink { [weak self] user in
          t = user.locationUser
                self?.txtVBio.text = user.bio
                
                self?.imgDummyCoverCamera.isHidden = true
                self?.imgDummyProfileCamera.isHidden = true
                
                // self?.imgProfile.sd_setImage(with: URL(string: user.avatarPath))
                //self?.imgCoverHeader.sd_setImage(with: URL(string: user.coverPath))
                
               
                
                self?.viewModelEditProfile.nameEditProfile = self?.txtName.text
                self?.viewModelEditProfile.bioEditProfile = self?.txtVBio.text
                self?.viewModelEditProfile.usernameEditProfile = self?.txtUsername.text
                self?.viewModelEditProfile.birthDateEditProfile = self?.txtBirthdate.text
                self?.viewModelEditProfile.locationEditProfile = self?.txtLocation.text
  self else {
                    return
                }
                
                if !(strongSelf.isNewImageSelectedFromPicker){
                    let urlProfile = URL(string: user.avatarPath)
                    self?.imgProfile.sd_setImage(with: urlProfile, placeholderImage: UIImage(named: ""),options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
                        self?.viewModelEditProfile.imageDataProfileEditProfile = image
                    })
                    
                    let urlCover = URL(string: user.coverPath)
                    self?.imgCoverHeader.sd_setImage(with: urlCover, placeholderImage: UIImage(named: ""),options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
                        self?.viewModelEditProfile.imageDataCoverEditProfile = image
          
                self?.btnSave.layer.opacity = 1.0
            }else{
                self?.btnSave.layer.opacity =  self?.opacityDisableLayer ?? 0.3
            }
        }
        .store(in: &subscriptionsEditProfile)
        
        
        viewModelEditProfile.$isOnboardingFinishedEditProfile.sink { [weak self] success in
            if success {
              
                guard let strongSelf = self else {
                    return
                }
                Utils.showAlertHandler(title: "Success", message: "Profile has been successfully updated.", view: strongSelf) { action in
                    strongSelf.dismiss(animated: true)
                }
                 
            }
      
        let calendar = Calendar(identifier: .gregorian)
        datePicker.backgroundColor = .systemBackground
        datePicker.datePickerMode = .date
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        //*** Create 1-1-1990 Default Date
        
        var dateComponents = DateComponents()
        dateComponents.year = 1990
        dateComponents.month = 1
        dateComponents.day = 1
        let defaultBDay = calendar.date(from: dateComponents)
        datePicker.date = defaultBDay ?? Date()

        //datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
     
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        txtBirthdate.inputAccessoryView = toolbar
        txtBirthdate.inputView = datePicker
    }
    
    
    //MARK: -  Buttons Actions
    @objc private func didUpdateDisplayName() {
      
    }
    
    @objc pr le = txtBirthdate.text
        viewModelEditProfile.validateUserEditProfileForm()
    }
    
    @objc private func didUpdateLocation() {
        viewModelEditProfile.locationEditProfile = txtLocation.text
        viewModelEditProfile.validateUserEditProfileForm()
    }
    
    @IBAction func btnSave(_ sender: Any) {
        
            
        }else if (txtVBio?.text ?? "") == "Tell the world about yourself"{
            Utils.showAlert(title: "Invalid", message: "Please enter bio and it should be atleast 3 characters", view: self)
            
        } else if (txtUsername?.text ?? "").containsWhitespaceAndNewlines(){
            
         Invalid", message: "Profile and Cover images should not be empty. You must have to select both images", view: self)
        }else{
            print("Called")
            viewModelEditProfile.uploadProfilePhoto()
        }
       
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        Utils.showAlert(title: "Required", message: "You must have to fill out this form with the accurate information", view: self)
       
    }
    
    
    @IBAction func btnCoverHeader(_ sender: Any) {
         tedFromPicker = true
                self.imgCoverHeader.image = photo.image
                self.viewModelEditProfile.imageDataCoverEditProfile = photo.image
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.viewModelEditProfile.validateUserEditProfileForm()
                }
               
                
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.present(picker, animated: true, completion: nil)
        }
        
    }
    
    @IBAc lectedFromPicker = true
                self.imgDummyProfileCamera.isHidden = true
                self.imgProfile.image = photo.image
                self.viewModelEditProfile.imageDataProfileEditProfile = photo.image
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.viewModelEditProfile.validateUserEditProfileForm()
                }
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.present(picker, animated: true, completion: nil)
        }
    print(photo.fromCamera) // Image source (camera or library)
   
    print(photo.originalImage) // original image selected by the user, unfiltered
    print(photo.modifiedImage) // Transformed image, can be nil
    print(photo.exifMeta) // Print exif meta data of original image.
     */
   
    
     lidateUserEditProfileForm()
        /*
        let formatter1 = DateFormatter()
        formatter1.dateFormat =  "yyyy-MM-dd"
        savedBDate = formatter1.string(from: datePicker.date)
        */
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
   
    
}

//MARK: -  UITextViewDelegate, UITextFieldDelegate
extension EditProfileVC : UITextViewDelegate,UITextFieldDelegate{
     
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        lblEditProfileAndCounter.text = "Edit Profile"
        if textView.text.isEmpty {
            textView.text = "Tell the world about yourself"
        : String) -> Bool {
        if txtBirthdate == textField{
            return false
        }
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        return newString.count <= 20
     /*
        switch textField {
        case txtName:
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= 20
        case txtUsername:
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= 20
 
        }
       */
    }
     
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = (newText.count + 1)
        if numberOfChars > 5{
            lblEditProfileAndCounter.text = "(\(self.totalAllowedCharacters - numberOfChars)/\(self.totalAllowedCharacters))"
        }else{
            lblEditProfileAndCounter.text = "Counting..."
        }
         
        
        return numberOfChars < self.totalAllowedCharacters
    }
     
}
