//
//  ProfileViewViewModel.swift
//  TwitterCloneHarsh
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
    
    
    func retreiveUserProfile(userId : String) {
        //guard let id = Auth.auth().currentUser?.uid else { return }
        Utils.showLoader(true)
        FireBaseDatabaseManager.shared.getUserByID(userId)
            .sink { [weak self] completion in
                
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM YYYY"
        return dateFormatter.string(from: date)
    }
    
    func fetchSelectedUserTweetsProfile() {
        Utils.showLoader(true)
        guard let userID = userProfile?.id else { return }
        FireBaseDatabaseManager.shared.getTweetsByUserID(userID)
            .sink { [weak self] completion in
                Utils.showLoader(false)
                if case .failure(let error) = completion {
                    self?.errorProfile = error.localizedDescription
                }
            } receiveValue: { [weak self] retreivedTweets in
                Utils.showLoader(false)
                self?.tweetsProfile = retreivedTweets
            }
            .store(in: &subscriptions)

    }
    
}
