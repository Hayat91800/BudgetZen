//
//  StatisticView.swift
//  Budget_zen
//
//  Created by apprenant144 on 01/07/2026.
//

import SwiftUI

struct StatisticView: View {
    @Environment(ViewModel.self) private var viewModel
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                LazyVGrid(columns: columns, spacing: 18) {
                    
                    VStack(spacing: 4) {
                        
                        Text("Title")
                            .font(.headline)
                            .foregroundStyle(.blue)
                        
                        
                        Text("""
                        **Age:** 
                        **Orgines:** 
                        **Style:** 
                        """)
                        .multilineTextAlignment(.center)
                        .padding()
                        
                        Button("Site web") {
                            
                        }.buttonStyle(.borderedProminent)
                            .tint(.red)
                            .controlSize(.regular)
                            .padding()
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color.gray)
                .cornerRadius(22)
                .padding()
            }
        }
    }
}


#Preview {
    StatisticView()
        .environment(ViewModel())
}
