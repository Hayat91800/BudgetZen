//
//  Transactions.swift
//  Budget_zen
//
//  Created by apprenant144 on 30/06/2026.
//

import Foundation
import SwiftUI

/// Type d'une transaction : elle ajoute (revenu) ou retire (dépense) de l'argent.
enum TransactionType: String, CaseIterable, Hashable {
    case revenu = "Revenu"
    case depense = "Dépense"

    /// Vert pour les revenus, rouge pour les dépenses
    var color: Color {
        switch self {
        case .revenu: return .zenRevenu
        case .depense: return .zenDepenses
        }
    }

    /// Signe affiché devant le montant
    var signe: String {
        switch self {
        case .revenu: return "+"
        case .depense: return "-"
        }
    }
}

struct Transaction: Identifiable, Hashable {

    var id = UUID()
    var title: String
    var amount: Double          // Montant toujours positif, c'est le type qui indique le sens
    var category: Category
    var type: TransactionType
    var date: String            // Date sous forme de texte (ex : "18/06/2026")

    var isRevenu: Bool { type == .revenu }

    /// Montant avec son signe pour les calculs : + pour un revenu, - pour une dépense
    var signedAmount: Double { isRevenu ? amount : -amount }

    /// Montant formaté avec son signe : "+1 200,00 €" ou "-85,00 €"
    var formattedAmount: String {
        type.signe + amount.formatted(.currency(code: "EUR"))
    }
}
