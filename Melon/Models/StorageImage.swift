//
//  StorageImage.swift
//  Melon
//
//  Created by Samiul Hoque on 12/19/22.
//

import Foundation

struct StorageImage: Identifiable {
    var id: String
    var url: String
}

extension StorageImage {
    init(url: String) {
        self.init(id: UUID().uuidString, url: url)
    }
}
