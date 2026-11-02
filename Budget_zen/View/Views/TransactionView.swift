//
//  TransactionView.swift
//  Budget_zen
//
//  Created by apprenant144 on 01/07/2026.
//

import SwiftUI

/// Fonctionnalités 2, 4 et 5 – Liste, recherche et filtre des transactions
struct TransactionView: View {
    @Environment(ViewModel.self) private var viewModel
    @State private var showAjout = false

    var body: some View {

        @Bindable var viewModel = viewModel
        let resultats = viewModel.transactionsFiltrees()

        NavigationStack {
            VStack(spacing: 0) {

                // Filtre : Toutes / Revenus / Dépenses
                Picker("Filtre", selection: $viewModel.selectedFilter) {
                    ForEach(FiltreTransaction.allCases, id: \.self) { filtre in
                        Text(filtre.rawValue).tag(filtre)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                .background(Color(.systemGroupedBackground))

                List {
                    if resultats.isEmpty {
                        ContentUnavailableView(
                            "Aucune transaction",
                            systemImage: "magnifyingglass",
                            description: Text("Aucune transaction ne correspond à votre recherche."))
                    }

                    ForEach(resultats) { transaction in
                        TransactionRow(transaction: transaction)
                            .alignmentGuide(.listRowSeparatorLeading) { _ in 0 } // Aligne le séparateur sur le bord avant
                            .swipeActions {
                                Button(role: .destructive) {
                                    withAnimation { viewModel.supprimerTransaction(transaction) }
                                } label: {
                                    Label("Supprimer", systemImage: "trash")
                                }
                            }
                    }
                }
            }
            .navigationTitle("Transactions")
            .searchable(text: $viewModel.research, placement: .navigationBarDrawer(displayMode: .always), prompt: "Rechercher par titre")
            .textInputAutocapitalization(.never)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAjout = true
                    } label: {
                        Label("Ajouter", systemImage: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $showAjout) {
                AjoutFormView(fermerApresAjout: true)
            }
        }
    }
}

/// Une ligne de la liste : titre, montant, catégorie, type et date
struct TransactionRow: View {
    let transaction: Transaction

    var body: some View {
        HStack(spacing: 16) {

            Image(systemName: transaction.category.icon)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(width: 40, height: 40)
                .foregroundStyle(transaction.type.color)
                .background(transaction.type.color.opacity(0.15))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text(transaction.category.rawValue)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(transaction.date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 6) {
                Text(transaction.formattedAmount)
                    .font(.headline)
                    .foregroundStyle(transaction.type.color)

                // Badge Revenu / Dépense
                Text(transaction.type.rawValue)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .foregroundStyle(.white)
                    .background(transaction.type.color)
                    .clipShape(Capsule())
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TransactionView()
        .environment(ViewModel())
}
