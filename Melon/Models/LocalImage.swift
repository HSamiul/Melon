//
//  LocalImage.swift
//  Melon
//
//  Created by Samiul Hoque on 12/19/22.
//

import Foundation
import SwiftUI
import PhotosUI

struct LocalImage: Identifiable {
    var id: String
    var uiImage: UIImage
}

extension LocalImage {
    var image: Image {
        Image(uiImage: uiImage)
    }
}

extension LocalImage {
    init(uiImage: UIImage) {
        self.init(id: UUID().uuidString, uiImage: uiImage)
    }
}
