//
//  ComposeTweetViewModel.swift
//  TwitterHarsh
//
//  Created by My Mac Mini on 28/12/23.
//

import Foundation
import Combine

 ns: Set<AnyCancellable> = []
    private var user: TwitterUser?

    var tweetContent: String = ""
    
    func g lse)
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] twitterUser in
                Utils.showLoader(false)
                self?.user = twitterUser
            }
            .store(in: &subscriptions)
 () {
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



