//
//  MainTabBarController.swift
//  TwitterHarsh
//
//  Created by My Mac Mini on 29/12/23.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
 igationController(rootViewController: homeVC)
        
        let searchStory: UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_SEARCH, bundle: nil)
        guard let searchVC = searchStory.instantiateViewController(withIdentifier: Constants.VC_SEARCH) as? SearchVC else { return }
        let navigationSearch = UINavigationController(rootViewController: searchVC)
        
        let editProfileStory: UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_EDIT_PROFILE, bundle: nil)
        guard let editProfileVC = editProfileStory.instantiateViewController(withIdentifier:  e = UINavigationController(rootViewController: userProfileVC)
       
        
        navigationHome.tabBarItem.image = UIImage(systemName: "house")
        navigationHome.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        navigationSearch.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        navigationSearch.tabBarItem.selectedImage = UIImage(systemName: "sparkle.magnifyingglass")
        
        navigationEditProfile.tabBarItem.image = UIImage(systemName: "person.badge.plus")
        navigationEditProfile.tabBarItem.selectedImage = UIImage(systemName:  [navigationHome, navigationSearch, navigationEditProfile, navigationUserProfile], animated: true)
         
        
    }
    
 
}
