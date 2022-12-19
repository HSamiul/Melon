//
//  UserData.swift
//  Melon
//
//  Created by Samiul Hoque on 12/19/22.
//

import Foundation
import FirebaseFirestoreSwift

struct UserData: Identifiable {
    @DocumentID var id: String?
    var displayName: String
    var profilePictureURL: String?
}

extension UserData: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case displayName = "display_name"
        case profilePictureURL = "profile_picture_url"
    }
}

extension UserData {
    init() {
        self.init(displayName: "")
    }
    
    init(uid: String, displayName: String, profilePictureURL: String) {
        self.init(id: uid,
                  displayName: displayName,
                  profilePictureURL: profilePictureURL)
    }
}
