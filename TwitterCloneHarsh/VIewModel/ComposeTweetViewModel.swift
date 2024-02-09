//
//  ComposeTweetViewModel.swift
//  TwitterCloneHarsh
//
//  Created by My Mac Mini on 28/12/23.
//

import Foundation
import Combine
import FirebaseAuth

final class ComposeTweetViewModel: ObservableObject {
    
    @Published var isValidToTweet: Bool = false
    @Published var error: String = ""
    @Published var shouldDismissComposer: Bool = false

    private var subscriptions: Set<AnyCancellable> = []
    private var user: TwitterUser?

    var tweetContent: String = ""
    
    func getUserData() {
        Utils.showLoader(true)
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        FireBaseDatabaseManager.shared.getUserByID(userID)
            .sink { [weak self] completion in
                
                Utils.showLoader(false)
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] twitterUser in
                Utils.showLoader(false)
                self?.user = twitterUser
            }
            .store(in: &subscriptions)

    }
    
    func validateToTweet() {
        isValidToTweet = tweetContent.count > 100 ? true : false
         
    }
    
    func dispatchTweet() {
        Utils.showLoader(true)
        guard let user = user else { return }
        let tweet = Tweet(author: user, authorID: user.id, tweetContent: tweetContent, likesCount: 0, likers: [], isReply: false, parentReference: nil, createdOn: Date())
        FireBaseDatabaseManager.shared.composeTweet(tweet)
            .sink { [weak self] completion in
                Utils.showLoader(false)
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] state in
                Utils.showLoader(false)
                self?.shouldDismissComposer = state
            }
            .store(in: &subscriptions)

    }
    
    
}



