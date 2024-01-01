//
//  FireBaseDatabaseManager.swift
//  TwitterHarsh
//
//  Created by My Mac Mini  
//

import Foundation
import Firebase


class FireBaseDatabaseManager{
    static let shared = FireBaseDatabaseManager()
    
    // set firebase path and varibles
    let myDbFire = Firestore.firestore()
    let usersPath: String = "users"
    let tweetsPath: String = "tweets"
     
    
    .setData(from: twitterUser)
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
        
            .map { _ in true }
            .eraseToAnyPublisher()
    }
    
    //create new tweet
    func composeTweet(_ tweet: Tweet) -> AnyPublisher<Bool, Error> {
        
            .eraseToAnyPublisher()
    }
    
    
    //get tweets of user
    func getTweetsByUserID(_ forUserID: String) -> AnyPublisher<[Tweet], Error> {
        myDbFire.collection(tweetsPath).whereField("author.id", isEqualTo: forUserID)
           
    
    //.order(by: "createdOn", descending: true)
    
    //get all tweets of all user as publish date
    func getAllTweets() -> AnyPublisher<[Tweet], Error> {
        myDbFire.collection(tweetsPath)
        
            .tryMap { snapshots in
                try snapshots.map({
                    try $0.data(as: Tweet.self)
    
    
    
}
