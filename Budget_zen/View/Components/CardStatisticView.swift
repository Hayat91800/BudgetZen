//
//  CardStatisticView.swift
//  Budget_zen
//
//  Created by apprenant144 on 06/07/2026.
//

import SwiftUI

/// Petite carte d'une statistique
struct CardStatisticView: View {

    let title: String
    let value: String
    var detail: String? = nil
    var valueColor: Color = .primary

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.zenText.opacity(0.8))
                .multilineTextAlignment(.center)

            Text(value)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(valueColor)
                .minimumScaleFactor(0.6)
                .lineLimit(1)

            if let detail {
                Text(detail)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 100)
        .background(Color.zenBackgroundCard)
        .clipShape(.rect(cornerRadius: 22))
    }
}

#Preview {
    CardStatisticView(title: "Plus grand revenu", value: "1 200,00 €", detail: "Salaire Juin", valueColor: .green)
        .padding()
}
