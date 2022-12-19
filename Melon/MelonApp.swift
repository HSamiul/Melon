//
//  MelonApp.swift
//  Melon
//
//  Created by Samiul Hoque on 12/19/22.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
}

@main
struct MelonApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
