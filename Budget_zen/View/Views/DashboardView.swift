//
//  DashboardView.swift
//  Budget_zen
//
//  Created by apprenant144 on 03/07/2026.
//

import SwiftUI

/// Fonctionnalité 1 – Écran d'accueil / Tableau de bord
struct DashboardView: View {

    @Environment(ViewModel.self) private var viewModel

    var body: some View {
        let transactions = viewModel.transactions
        let solde = viewModel.solde(transactions)

        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // Message d'accueil
                    Text("Bienvenue Hayat 👋")
                        .font(.title3)
                        .fontWeight(.bold)

                    // Message automatique selon le solde
                    Text(viewModel.messageSolde(solde))
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(solde < 0 ? Color.zenDepenses : Color.zenText)

                    // Les 3 cartes obligatoires
                    CardDashboardView(
                        title: "Solde actuel",
                        value: solde.formatted(.currency(code: "EUR")),
                        icon: "wallet.bifold.fill",
                        valueColor: solde >= 0 ? .zenRevenu : .zenDepenses)

                    HStack(spacing: 12) {
                        CardDashboardView(
                            title: "Revenus",
                            value: viewModel.totalRevenus(transactions).formatted(.currency(code: "EUR")),
                            icon: "arrow.down.circle.fill",
                            valueColor: .zenRevenu)

                        CardDashboardView(
                            title: "Dépenses",
                            value: viewModel.totalDepenses(transactions).formatted(.currency(code: "EUR")),
                            icon: "arrow.up.circle.fill",
                            valueColor: .zenDepenses)
                    }

                    // Résumé rapide du nombre de transactions
                    CardDashboardView(
                        title: "Résumé",
                        value: "\(viewModel.countAllTransaction(transactions)) transactions",
                        icon: "list.bullet.circle.fill",
                        valueColor: .blue)

                    Text("\(viewModel.countAllRevenus(transactions)) revenus · \(viewModel.countAllDepenses(transactions)) dépenses")
                        .font(.footnote)
                        .foregroundStyle(.secondary)

                    // Fonctionnalité 7 – Conseil
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Conseil", systemImage: "lightbulb.fill")
                            .font(.headline)
                            .foregroundStyle(.orange)

                        Text(viewModel.conseil(transactions))
                            .font(.body)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.orange.opacity(0.12))
                    .clipShape(.rect(cornerRadius: 22))
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("BudgetZen")
        }
    }
}

#Preview {
    DashboardView()
        .environment(ViewModel())
}
