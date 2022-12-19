//
//  RegistrationService.swift
//  Melon
//
//  Created by Samiul Hoque on 12/19/22.
//

import Foundation
import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseAuth

enum RegistrationServiceError {
    case passwordsDontMatch
}

extension RegistrationServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .passwordsDontMatch:
            return "Passwords do not match."
        }
    }
}

struct RegistrationForm {
    var displayName: String
    var email: String
    var password: String
    var passwordConfirmation: String
    var item: PhotosPickerItem
}

protocol RegistrationServiceProtocol {
    func register(with form: RegistrationForm) async throws
}

class RegistrationService: RegistrationServiceProtocol {
    var auth = Auth.auth()
    var collectionRef = Firestore.firestore().collection("user_data")
    
    func register(with form: RegistrationForm) async throws {
        try validate(form: form)
        
        let storageImage = try await uploadProfilePicture(from: form)
        
        let authResult = try await auth.createUser(withEmail: form.email,
                                                   password: form.password)
        
        let userData = UserData(uid: authResult.user.uid,
                                displayName: form.displayName,
                                profilePictureURL: storageImage.url)
        
        let ref = collectionRef.document(authResult.user.uid)
        
        try ref.setData(from: userData)
    }
}

private extension RegistrationService {
    func validate(form: RegistrationForm) throws {
        if (form.password != form.passwordConfirmation) {
            throw RegistrationServiceError.passwordsDontMatch
        }
    }
    
    func uploadProfilePicture(from form: RegistrationForm) async throws -> StorageImage {
        let data = try await ImageService.convertToData(item: form.item)
        
        let storageImage = try await StorageService.upload(item: form.item,
                                                                path: "profile_pictures")
        
        return storageImage
    }
}
