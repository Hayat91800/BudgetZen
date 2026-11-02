//
//  StatisticView.swift
//  Budget_zen
//
//  Created by apprenant144 on 01/07/2026.
//

import SwiftUI

/// Fonctionnalité 6 – Écran statistiques
/// Tous les calculs sont faits dans des fonctions du ViewModel, pas dans l'interface.
struct StatisticView: View {
    @Environment(ViewModel.self) private var viewModel

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        let transactions = viewModel.transactions
        let solde = viewModel.solde(transactions)
        let plusGrandRevenu = viewModel.plusGrandRevenu(transactions)
        let plusGrandeDepense = viewModel.plusGrandeDepense(transactions)

        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // Solde
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Solde")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)

                        Text(solde.formatted(.currency(code: "EUR")))
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundStyle(solde >= 0 ? Color.zenRevenu : Color.zenDepenses)

                        Text(viewModel.conseil(transactions))
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.zenBackgroundCard)
                    .clipShape(.rect(cornerRadius: 22))

                    section("Nombre de transactions") {
                        CardStatisticView(
                            title: "Total",
                            value: "\(viewModel.countAllTransaction(transactions))",
                            valueColor: .blue)

                        CardStatisticView(
                            title: "Revenus",
                            value: "\(viewModel.countAllRevenus(transactions))",
                            valueColor: .zenRevenu)

                        CardStatisticView(
                            title: "Dépenses",
                            value: "\(viewModel.countAllDepenses(transactions))",
                            valueColor: .zenDepenses)
                    }

                    section("Montants") {
                        CardStatisticView(
                            title: "Total des revenus",
                            value: viewModel.totalRevenus(transactions).formatted(.currency(code: "EUR")),
                            valueColor: .zenRevenu)

                        CardStatisticView(
                            title: "Total des dépenses",
                            value: viewModel.totalDepenses(transactions).formatted(.currency(code: "EUR")),
                            valueColor: .zenDepenses)

                        CardStatisticView(
                            title: "Plus grand revenu",
                            value: (plusGrandRevenu?.amount ?? 0).formatted(.currency(code: "EUR")),
                            detail: plusGrandRevenu?.title ?? "Aucun revenu",
                            valueColor: .zenRevenu)

                        CardStatisticView(
                            title: "Plus grande dépense",
                            value: (plusGrandeDepense?.amount ?? 0).formatted(.currency(code: "EUR")),
                            detail: plusGrandeDepense?.title ?? "Aucune dépense",
                            valueColor: .zenDepenses)

                        CardStatisticView(
                            title: "Moyenne des dépenses",
                            value: viewModel.averageDepense(transactions).formatted(.currency(code: "EUR")),
                            valueColor: .orange)

                        CardStatisticView(
                            title: "Catégorie la plus utilisée",
                            value: viewModel.mostUseCategory(transactions),
                            valueColor: .purple)
                    }

                    // Bonus : nombre de transactions par catégorie
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Par catégorie")
                            .font(.headline)
                            .foregroundStyle(.secondary)

                        ForEach(viewModel.nombreParCategorie(transactions), id: \.category) { ligne in
                            HStack {
                                Label(ligne.category.rawValue, systemImage: ligne.category.icon)
                                Spacer()
                                Text("\(ligne.nombre)")
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    .padding()
                    .background(Color.zenBackgroundCard)
                    .clipShape(.rect(cornerRadius: 22))
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Statistiques")
        }
    }

    /// Titre de section + grille de cartes
    private func section<Content: View>(_ titre: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(titre)
                .font(.headline)
                .foregroundStyle(.secondary)

            LazyVGrid(columns: columns, spacing: 16) {
                content()
            }
        }
    }
}

#Preview {
    StatisticView()
        .environment(ViewModel())
}
