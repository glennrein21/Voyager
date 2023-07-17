//
//  VoyagerApp.swift
//  Voyager
//
//  Created by Glenn Reinard Stanis on 20/05/23.
//

import SwiftUI

@main
struct VoyagerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
