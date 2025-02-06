//
//  GreatTeachers2App.swift
//  GreatTeachers2
//
//  Created by Macbook Pro on 04/02/25.
//

import SwiftUI

@main
struct GreatTeachers2App: App {
    
    //@StateObject var vm = SignInViewModel()
    let dataManager = NetworkingManager.shared
    
    var body: some Scene {
        WindowGroup {
            StarterView()
        }
    }
}
