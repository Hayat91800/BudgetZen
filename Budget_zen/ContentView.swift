//
//  ContentView.swift
//  Budget_zen
//
//  Created by apprenant144 on 30/06/2026.
//

import SwiftUI

/// Navigation par onglets : Accueil, Transactions, Ajouter, Statistiques
struct ContentView: View {

    var body: some View {
        TabView {
            DashboardView()
                .tabItem { Label("Accueil", systemImage: "house.fill") }

            TransactionView()
                .tabItem { Label("Transactions", systemImage: "list.bullet.rectangle.fill") }

            AjoutFormView()
                .tabItem { Label("Ajouter", systemImage: "plus.circle.fill") }

            StatisticView()
                .tabItem { Label("Statistiques", systemImage: "chart.bar.fill") }
        }
    }
}

#Preview {
    ContentView()
        .environment(ViewModel())
}
