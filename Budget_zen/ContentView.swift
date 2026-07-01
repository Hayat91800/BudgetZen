//
//  ContentView.swift
//  Budget_zen
//
//  Created by apprenant144 on 30/06/2026.
//

import SwiftUI

struct ContentView: View {
    @Environment(ViewModel.self) private var vm
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environment(ViewModel())
}
