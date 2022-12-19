//
//  StorageService.swift
//  Melon
//
//  Created by Samiul Hoque on 12/19/22.
//

import Foundation
import SwiftUI
import PhotosUI
import FirebaseStorage

protocol StorageServiceProtocol {
    static func upload(item: PhotosPickerItem, path: String) async throws -> StorageImage
}

class StorageService: StorageServiceProtocol {
    static var storageRef = Storage.storage().reference()
    
    static func upload(item: PhotosPickerItem, path: String) async throws -> StorageImage {
        let localImage = try await ImageService.convertToLocalImage(item: item)
        
        let ref = storageRef.child("\(path)\(localImage.id).jpeg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        let data = try ImageService.convertToJPEGData(uiImage: localImage.uiImage)
        
        _ = try await ref.putDataAsync(data)
        let url = try await ref.downloadURL()
        
        return StorageImage(url: url.absoluteString)
    }
}
