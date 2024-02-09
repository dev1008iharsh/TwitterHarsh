//
//  ProfileDataViewViewModel.swift
//  TwitterCloneHarsh
//
//  Created by My Mac Mini on 28/12/23.
//

import Foundation
import Combine
import UIKit
import FirebaseAuth
import FirebaseStorage


final class EditProfileViewModel: ObservableObject {
    
    
   
    @Published var userEditProfile: TwitterUser?
    
    @Published var nameEditProfile: String?
    @Published var usernameEditProfile: String?
    @Published var birthDateEditProfile: String?
    @Published var locationEditProfile: String?
    @Published var bioEditProfile: String?
    @Published var imgProfileEditProfile: String?
    @Published var imgCoverEditProfile: String?
    @Published var imageDataProfileEditProfile: UIImage?
    @Published var imageDataCoverEditProfile: UIImage?
    @Published var isFormValidEditProfile: Bool = false
    @Published var errorEditProfile: String = ""
    @Published var isOnboardingFinishedEditProfile: Bool = false
    
    private var subscriptions: Set<AnyCancellable> = []
    
    func validateUserEditProfileForm() {
        guard let displayName = nameEditProfile,
              displayName.count > 2,
              
              let username = usernameEditProfile,
              username.count > 2,
              
              let birthDate = birthDateEditProfile,
              birthDate.count > 2,
              
              let locationUser = locationEditProfile,
              locationUser.count > 2,
              
              let bio = bioEditProfile,
              bio.count > 2,
              
              imageDataProfileEditProfile != nil,
              
              imageDataCoverEditProfile != nil
                
        else {
            
            isFormValidEditProfile = false
            return
            
        }
        isFormValidEditProfile = true
    }
    
    func retreiveEditProfileUser() {
        
        Utils.showLoader(true)
        guard let id = Auth.auth().currentUser?.uid else { return }
        FireBaseDatabaseManager.shared.getUserByID(id)
            .sink { [weak self] completion in
                Utils.showLoader(false)
                if case .failure(let error) = completion {
                    self?.errorEditProfile = error.localizedDescription
                    print("*** retreiveUser For Profile",error)
                }
            } receiveValue: { [weak self] user in
                Utils.showLoader(false)
                self?.userEditProfile = user
            }
            .store(in: &subscriptions)

    }
    
    
    func uploadProfilePhoto() {
        Utils.showLoader(true)
        let randomID = UUID().uuidString
        // 0 most 1 least -> 0.5 medium image upload quality
        guard let imageData = imageDataProfileEditProfile?.jpegData(compressionQuality: 1) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        FireBaseStorageManager.shared.uploadProfileImageUrl(randomID, image: imageData, metaData: metaData)
            .flatMap({ metaData in
                FireBaseStorageManager.shared.getImageFromFireBaseUrl(metaData.path)
            })
            .sink { [weak self] completion in
                Utils.showLoader(false)
                switch completion {
                case .failure(let error):
                    print("*** Error AT uploadAvatar",error.localizedDescription)
                    self?.errorEditProfile = error.localizedDescription
                
                case .finished:
                    Utils.showLoader(true)
                    self?.uploadCoverImage()
                    print("*** finished AT uploadAvatar")
                }
                
            } receiveValue: { [weak self] url in
                self?.imgProfileEditProfile = url.absoluteString
            }
            .store(in: &subscriptions)
        
        
    }
    
    private func updateUserEditProfileData() {
        guard let nameEditProfile,
              let usernameEditProfile,
              let bioEditProfile,
              let imgProfileEditProfile,
              let birthDateEditProfile,
              let locationEditProfile,
              let imgCoverEditProfile,
              let id = Auth.auth().currentUser?.uid else { return }
        
        let updatedFields: [String: Any] = [
            "displayName": nameEditProfile,
            "birthDate": birthDateEditProfile,
            "locationUser": locationEditProfile,
            "username": usernameEditProfile,
            "bio": bioEditProfile,
            "avatarPath": imgProfileEditProfile,
            "coverPath": imgCoverEditProfile,
            "isUserOnboarded": true
        ]
        /*
        let updatedFields: [String: Any] = [
            "displayName": displayName,
            "birthDate": birthDate,
            "locationUser": locationUser,
            "username": username,
            "bio": bio,
            "avatarPath": avatarPath,
            "coverPath": coverPath,
            "isUserOnboarded": true
        ]*/
        
        FireBaseDatabaseManager.shared.updateUserProfile(updateFields: updatedFields, id)
            .sink { [weak self] completion in
                Utils.showLoader(false)
                if case .failure(let error) = completion {
                    print("*** Error AT updateUserData",error.localizedDescription)
                    self?.errorEditProfile = error.localizedDescription
                }
            } receiveValue: { [weak self] onboardingState in
                
                Utils.showLoader(false)
                print("*** Completed Task")
                self?.isOnboardingFinishedEditProfile = onboardingState
            }
            .store(in: &subscriptions)

    }
    
    
    func uploadCoverImage() {
        let randomID = UUID().uuidString
        // 0 most 1 least -> 0.5 medium image upload quality
        guard let imageData = imageDataCoverEditProfile?.jpegData(compressionQuality: 1) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        FireBaseStorageManager.shared.uploadCoverImageURl(randomID, image: imageData, metaData: metaData)
            .flatMap({ metaData in
                FireBaseStorageManager.shared.getImageFromFireBaseUrl(metaData.path)
            })
            .sink { [weak self] completion in
                Utils.showLoader(false)
                switch completion {
                case .failure(let error):
                    print("*** Error AT uploadCover",error.localizedDescription)
                    self?.errorEditProfile = error.localizedDescription
                
                case .finished:
                    print("*** finished AT uploadCover")
                    Utils.showLoader(true)
                    self?.updateUserEditProfileData()
                }
                
            } receiveValue: { [weak self] url in
                self?.imgCoverEditProfile = url.absoluteString
            }
            .store(in: &subscriptions)
        
        
    }
    
    
}
