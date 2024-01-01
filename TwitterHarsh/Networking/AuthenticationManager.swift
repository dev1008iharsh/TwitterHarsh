//
//  AuthenticationManager.swift
//  TwitterHarsh
//
//  Created by My Mac Mini 
//

import Combine

class AuthenticationManager {
    
    // singltone class
    static let shared = AuthenticationManager()
     
    func userRegistrationFunc(_ email: String, password: String) -> AnyPublisher<User, Error> {
        return Auth.auth().createUser(withEmail: email, password: password)
            
            .eraseToAnyPublisher()
    }
    
    func userLoginFunc(_ email: String, password: String) -> AnyPublisher<User, Error> {
        return Auth.auth().signIn(withEmail: email, password: password)
            .map(\.user)
             
    }
}
