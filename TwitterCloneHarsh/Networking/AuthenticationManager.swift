//
//  AuthManager.swift
//  TwitterCloneHarsh
//
//  Created by My Mac Mini on 27/12/23.
//

import Firebase
import FirebaseAuthCombineSwift
import Combine

class AuthenticationManager {
    
    // singltone class
    static let shared = AuthenticationManager()
     
    func userRegistrationFunc(_ email: String, password: String) -> AnyPublisher<User, Error> {
        return Auth.auth().createUser(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
    
    func userLoginFunc(_ email: String, password: String) -> AnyPublisher<User, Error> {
        return Auth.auth().signIn(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
}
