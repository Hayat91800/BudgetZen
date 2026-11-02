//
//  Category.swift
//  Budget_zen
//
//  Created by apprenant144 on 01/07/2026.
//

import Foundation
import SwiftUI

enum Category: String, CaseIterable, Hashable {
    case Salaire, Virement, Cadeaux, Alimentation, Logement, Transport, Loisirs, Autre

    /// Catégories proposées dans le formulaire selon le type choisi.
    /// "Autre" est disponible pour les deux types (ex : "Vente occasion" = revenu / Autre).
    static func categories(pour type: TransactionType) -> [Category] {
        switch type {
        case .revenu:
            return [.Salaire, .Virement, .Cadeaux, .Autre]
        case .depense:
            return [.Alimentation, .Logement, .Transport, .Loisirs, .Autre]
        }
    }

    var icon: String {
        switch self {
        case .Salaire:
            return "banknote.fill"
        case .Virement:
            return "arrow.up.right.and.arrow.down.left.rectangle.fill"
        case .Cadeaux:
            return "gift.fill"
        case .Alimentation:
            return "cart.fill"
        case .Logement:
            return "house.fill"
        case .Transport:
            return "tram.fill.tunnel"
        case .Loisirs:
            return "gamecontroller.fill"
        case .Autre:
            return "creditcard.fill"
        }
    }
}
