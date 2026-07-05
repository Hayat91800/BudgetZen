//
//  Budget_zenApp.swift
//  Budget_zen
//
//  Created by apprenant144 on 30/06/2026.
//

import SwiftUI

@main
struct Budget_zenApp: App {
    @State private var data = MockData()
    @State private var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(data)
                .environment(viewModel)
        }
    }
}

