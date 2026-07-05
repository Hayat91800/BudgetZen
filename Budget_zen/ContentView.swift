//
//  ContentView.swift
//  Budget_zen
//
//  Created by apprenant144 on 30/06/2026.
//

import SwiftUI

struct ContentView: View {
    @Environment(ViewModel.self) private var viewModel
    
    var body: some View {
        
        TabView {
            
            DashboardView()
                .tabItem {Label("Dashboard", systemImage: "square.grid.2x2.fill")}
            
            TransactionView()
                .tabItem {Label("Transaction", systemImage: "arrow.down.left.arrow.up.right.square.fill")}
            
            StatisticView()
                .tabItem {Label("Statistic", systemImage: "chart.bar.fill")}
            
        }
        }
    }


#Preview {
    ContentView()
        .environment(ViewModel())
}

