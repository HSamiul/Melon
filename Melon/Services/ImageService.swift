//
//  ImageService.swift
//  Melon
//
//  Created by Samiul Hoque on 12/19/22.
//

import Foundation
import SwiftUI
import PhotosUI

enum ImageServiceError {
    case failed
}

extension ImageServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .failed:
            return "Could not convert the selected media to an acceptable format."
        }
    }
}

protocol ImageServiceProtocol {
    static func convertToLocalImage(item: PhotosPickerItem) async throws -> LocalImage
}

class ImageService: ImageServiceProtocol {
    static func convertToLocalImage(item: PhotosPickerItem) async throws -> LocalImage {
        let data = try await convertToData(item: item)
        let uiImage = try convertToUIImage(data: data)
        return LocalImage(uiImage: uiImage)
    }
}

extension ImageService {
    static func convertToData(item: PhotosPickerItem) async throws -> Data {
        // Why not convert straight to Image.self?
        // loadTransferable(type: Image.self) only support .png files.
        // It's better to use Data.self and then create a UIImage from the data.
        
        let data = try await item.loadTransferable(type: Data.self)
        
        guard let data else {
            throw ImageServiceError.failed
        }
        
        return data
    }
    
    static func convertToUIImage(data: Data) throws -> UIImage {
        guard let uiImage = UIImage(data: data) else {
            throw ImageServiceError.failed
        }
        
        return uiImage
    }
    
    static func convertToJPEGData(uiImage: UIImage) throws -> Data {
        guard let data = uiImage.jpegData(compressionQuality: 1.0) else {
            throw ImageServiceError.failed
        }
        
        return data
    }
}
