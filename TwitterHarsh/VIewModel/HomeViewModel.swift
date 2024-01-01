//
//  HomeViewModel.swift
//  TwitterHarsh
//
//  Created by My Mac Mini on 28/12/23.
//



final class HomeViewModel: ObservableObject {
    
    @Published var userHome: TwitterUser?
    @Published var errorHome: String?
    @Published var tweetsHome: [Tweet] = []
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // at home we retrive current logged in user for that we can manage all data
    func retreiveCurrentLoggedInUser() {
        Utils.showLoader(true)
        
        guard let id = Auth.auth().currentUser?.uid else { return }
        FireBaseDatabaseManager.shared.getUserByID(id)
            .handleEvents(receiveOutput: { [weak self] user in
                Utils.showLoader(false)
                
                self?.userHome = user
                
                //self?.fetchAllTweets()
                //self?.fetchTweets()
                
            })
            .sink { [weak self] completion in
                
                Utils.showLoader(false)
                
                if case .failure(let error) = completion {
                    self?.errorHome = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                
                Utils.showLoader(false)
                
                self?.userHome = user
            }
            .store(in: &subscriptions)
    }
    
    // fetch only current user tweet for FROM YOU tab in home screen
    func fetchCurrentLoggedInUserTweets() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            Utils.showLoader(true)
        }
        // for the world case automatically loader stop
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            Utils.showLoader(false)
        }
        
        guard let userID = userHome?.id else { return }
        FireBaseDatabaseManager.shared.getTweetsByUserID(userID)
            .sink { [weak self] completion in
                Utils.showLoader(false)
                if case .failure(let error) = completion {
                    self?.errorHome = error.localizedDescription
                }
            } receiveValue: { [weak self] retreivedTweets in
                Utils.showLoader(false)
                self?.tweetsHome = retreivedTweets
            }
            .store(in: &subscriptions)

    }
    
    // fetch all tweets from database to show all tweets in home screen
    func fetchAllTweetsByAllUsers() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            Utils.showLoader(true)
        }
        // for the world case automatically loader stop
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            Utils.showLoader(false)
        }
        FireBaseDatabaseManager.shared.getAllTweets()
            .sink { [weak self] completion in
                Utils.showLoader(false)
                if case .failure(let error) = completion {
                    self?.errorHome = error.localizedDescription
                }
            } receiveValue: { [weak self] retreivedTweets in
                Utils.showLoader(false)
                self?.tweetsHome = retreivedTweets
            }
            .store(in: &subscriptions)

    }
    
    
}
