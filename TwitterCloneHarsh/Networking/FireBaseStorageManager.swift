//
//  StorageManager.swift
//  TwitterCloneHarsh
//
//  Created by My Mac Mini on 28/12/23.
//

import Foundation
import Combine
import FirebaseStorageCombineSwift
import FirebaseStorage

enum errorFireBase: Error {
    case invalidImageID
}



final class FireBaseStorageManager {
    
    static let shared = FireBaseStorageManager()
    
    let storage = Storage.storage()
    
    func getImageFromFireBaseUrl(_ id: String?) -> AnyPublisher<URL, Error> {
        guard let id = id else {
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
            .child("profiles/\(randomID).jpg")
            .putData(image, metadata: metaData)
            .print()
            .eraseToAnyPublisher()
    }
    
    func uploadCoverImageURl(_ randomID: String, image: Data, metaData: StorageMetadata) -> AnyPublisher<StorageMetadata, Error> {
        return storage
            .reference()
            .child("covers/\(randomID).jpg")
            .putData(image, metadata: metaData)
            .print()
            .eraseToAnyPublisher()
    }
}
