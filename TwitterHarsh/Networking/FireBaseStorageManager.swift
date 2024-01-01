//
//  FireBaseStorageManager.swift
//  TwitterHarsh
//
//  Created by My Mac Mini 
//

import FirebaseStorageCombineSwift
import FirebaseStorage

enum errorFireBase: Error {
    case invalidImageID
}



final class FireBaseStorageManager {
    
    static let shared = FireBaseStorageManager()
    
    let storage = Storage.storage()
    
   
            return Fail(error: errorFireBase.invalidImageID)
                .eraseToAnyPublisher()
        }
        return storage
            .reference(withPath: id)
            .downloadURL()
            .print()
            .eraseToAnyPublisher()
    }
    
    func uploadProfileImageUrl(_ randomID: String, image: Data, metaData: StorageMetadata) -> AnyPublisher<StorageMetadata, Error> {
        return storage
            .reference()
  
    
    func uploadCoverImageURl(_ randomID: String, image: Data, metaData: StorageMetadata) -> AnyPublisher<StorageMetadata, Error> {
        return storage
            .reference()
            .child("covers/\(randomID).jpg")
   
}
