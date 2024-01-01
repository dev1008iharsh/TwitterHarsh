//
//  AuthViewModel.swift
//  TwitterHarsh
//
//  Created by My Mac Mini on 27/12/23.
//

import Foundation
import FirebaseAuth
import Combine

final class AuthViewModel : ObservableObject{
   
    // declare variables
    @Published var userEmail : String?
    @Published var userPassword : String?
    @Published var isUserRegistrationFormValid : Bool = false
 
    private var subscriptions: Set<AnyCancellable> = []
    
    // this check function check data acoording to data - submit button (Enable-Disable) change
    func validateAuthForm(){
        guard let email = userEmail,
              let password = userPassword else {
            isUserRegistrationFormValid = false
            return
        }
        isUserRegistrationFormValid = Utils.isValidEmail(email) && password.count >= 8
    }
    
    // create user registration
    func createUserRegistration() {
        Utils.showLoader(true)
        guard let email = userEmail,
  
                print("*user",user)
                self?.userAuth = user
            })
            
            .sink { [weak self] completion in
                Utils.showLoader(false)
                if case .failure(let error) = completion {
                    print("error.localizedDescription",error.localizedDescription)
                    self?.errorAuth = error.localizedDescription
                }
                
            } receiveValue: { [weak self] user in
                Utils.showLoader(false)
     

    }
    
    // create record of user
    func createUserRecord(_ user: User) {
        Utils.showLoader(true)
        FireBaseDatabaseManager.shared.addUserFireBase(user)
            .sink { [weak self] completion in
                Utils.showLoader(false)
        
                print("Adding user record to database: \(state)")
            }
            .store(in: &subscriptions)

    }
    
    // login user
    func userLogin() {
        Utils.showLoader(true)
        guard let email = userEmail,
              let password = userPassword else { return }
        AuthenticationManager.shared.userLoginFunc(email, password: password)
            
            .sink { [weak self] completion in
                Utils.showLoader(false)
                if case .failure(let error) = completion {
                    self?.errorAuth = error.localizedDescription
                }
         
            
            .store(in: &subscriptions)

    }
    
    
}
