//
//  CardDashboardView.swift
//  Budget_zen
//
//  Created by apprenant144 on 01/07/2026.
//

import SwiftUI

/// Carte du tableau de bord (solde, revenus, dépenses…)
struct CardDashboardView: View {
    let title: String
    let value: String
    var icon: String = "eurosign.circle.fill"
    var valueColor: Color = .primary

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title)
                .foregroundStyle(valueColor)
                .frame(width: 44)

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.zenText.opacity(0.8))

                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(valueColor)
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.zenBackgroundCard)
        .clipShape(.rect(cornerRadius: 22))
    }
}

#Preview {
    CardDashboardView(title: "Solde actuel", value: "1 200,00 €", valueColor: .green)
        .padding()
}
