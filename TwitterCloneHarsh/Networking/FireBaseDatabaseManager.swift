//
//  DatabaseManager.swift
//  TwitterCloneHarsh
//
//  Created by My Mac Mini on 28/12/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift
import Combine
import FirebaseAuth

class FireBaseDatabaseManager{
    static let shared = FireBaseDatabaseManager()
    
    // set firebase path and varibles
    let myDbFire = Firestore.firestore()
    let usersPath: String = "users"
    let tweetsPath: String = "tweets"
     
    
    // add user tio firebase database
    func addUserFireBase(_ user: User) -> AnyPublisher<Bool, Error> {
        let twitterUser = TwitterUser(from: user)
        return myDbFire.collection(usersPath).document(twitterUser.id).setData(from: twitterUser)
            .map { _ in return true }
            .eraseToAnyPublisher()
    }
    
    //get perticular user from database by using his id
    func getUserByID(_ id: String) -> AnyPublisher<TwitterUser, Error> {
        myDbFire.collection(usersPath).document(id).getDocument()
            .tryMap { try $0.data(as: TwitterUser.self) }
            .eraseToAnyPublisher()
    }
    
    //change user profile data(name,city) or add data
    func updateUserProfile(updateFields: [String: Any], _ id: String) -> AnyPublisher<Bool, Error> {
        myDbFire.collection(usersPath).document(id).updateData(updateFields)
            .map { _ in true }
            .eraseToAnyPublisher()
    }
    
    //create new tweet
    func composeTweet(_ tweet: Tweet) -> AnyPublisher<Bool, Error> {
        myDbFire.collection(tweetsPath).document(tweet.id).setData(from: tweet)
            .map { _ in true }
            .eraseToAnyPublisher()
    }
    
    
    //get tweets of user
    func getTweetsByUserID(_ forUserID: String) -> AnyPublisher<[Tweet], Error> {
        myDbFire.collection(tweetsPath).whereField("author.id", isEqualTo: forUserID)
           
            .getDocuments()
            .tryMap(\.documents)
            .tryMap { snapshots in
                try snapshots.map({
                    try $0.data(as: Tweet.self)
                })
            }
            .eraseToAnyPublisher()
    }
    //.order(by: "createdOn", descending: true)
    
    //get all tweets of all user as publish date
    func getAllTweets() -> AnyPublisher<[Tweet], Error> {
        myDbFire.collection(tweetsPath)
            .order(by: "createdOn", descending: true)
            .getDocuments()
            
            .tryMap(\.documents)
            .tryMap { snapshots in
                try snapshots.map({
                    try $0.data(as: Tweet.self)
                })
            }
            .eraseToAnyPublisher()
    }
    
    
}
