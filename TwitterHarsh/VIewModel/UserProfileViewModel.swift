//
//  UserProfileViewModel.swift
//  TwitterHarsh
//
//  Created by My Mac Mini on 28/12/23.
//

import Foundation
import Combine
import FirebaseAuth



final class UserProfileViewModel: ObservableObject {
    
    @Published var userProfile: TwitterUser?
    @Published var errorProfile: String?
    @Published var tweetsProfile: [Tweet] = []
    private var subscriptions: Set<AnyCancellable> = []
    
     
                Utils.showLoader(false)
                if case .failure(let error) = completion {
                    self?.errorProfile = error.localizedDescription
                    print("*** retreiveUser For Profile",error.localizedDescription)
                    print("*** retreiveUser For Profile",error)
                }
            } receiveValue: { [weak self] user in
                Utils.showLoader(false)
                self?.userProfile = user
                self?.fetchSelectedUserTweetsProfile()
            }
            .store(in: &subscriptions)

    }
    
    
    func getFormattedDate(with date:  Date) -> String {
        e?.id else { return }
        FireBaseDatabaseManager.shared.getTweetsByUserID(userID)
            .sink { [weak self] completion in
                Utils.showLoader(false)
                if case .failure(let error) = completion {
                    self?.errorProfile = error.localizedDescription
                }
            } receiveValue: { [weak self] retreivedTweets in
           
    
}
