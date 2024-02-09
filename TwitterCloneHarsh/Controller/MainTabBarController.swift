//
//  MainTabBarController.swift
//  TwitterCloneHarsh
//
//  Created by My Mac Mini on 29/12/23.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = .colourTwitterBlue
        
        let homeStory: UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_HOME, bundle: nil)
        guard let homeVC = homeStory.instantiateViewController(withIdentifier: Constants.VC_HOME) as? HomeVC else { return }
        let navigationHome = UINavigationController(rootViewController: homeVC)
        
        let searchStory: UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_SEARCH, bundle: nil)
        guard let searchVC = searchStory.instantiateViewController(withIdentifier: Constants.VC_SEARCH) as? SearchVC else { return }
        let navigationSearch = UINavigationController(rootViewController: searchVC)
        
        let editProfileStory: UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_EDIT_PROFILE, bundle: nil)
        guard let editProfileVC = editProfileStory.instantiateViewController(withIdentifier: Constants.VC_EDIT_PROFILE) as? EditProfileVC else { return }
        let navigationEditProfile = UINavigationController(rootViewController: editProfileVC)
        
        let profileStory: UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_PROFILE, bundle: nil)
        guard let userProfileVC = profileStory.instantiateViewController(withIdentifier: Constants.VC_USER_PROFILE) as? UserProfileVC else { return }
        let navigationUserProfile = UINavigationController(rootViewController: userProfileVC)
       
        
        navigationHome.tabBarItem.image = UIImage(systemName: "house")
        navigationHome.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        navigationSearch.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        navigationSearch.tabBarItem.selectedImage = UIImage(systemName: "sparkle.magnifyingglass")
        
        navigationEditProfile.tabBarItem.image = UIImage(systemName: "person.badge.plus")
        navigationEditProfile.tabBarItem.selectedImage = UIImage(systemName: "person.fill.badge.plus")
        
        navigationUserProfile.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        navigationUserProfile.tabBarItem.selectedImage = UIImage(systemName: "person.crop.circle.fill")
        
        setViewControllers([navigationHome, navigationSearch, navigationEditProfile, navigationUserProfile], animated: true)
         
        
    }
    
 
}
