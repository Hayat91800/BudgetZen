//
//  MockData.swift
//  Budget_zen
//
//  Created by apprenant144 on 30/06/2026.
//

import Foundation

/// Données de départ de l'application (aucune base de données : tout est en mémoire).
enum MockData {

    static let transactions: [Transaction] = [
        Transaction(title: "Salaire Juin", amount: 1200.00, category: .Salaire, type: .revenu, date: "18/06/2026"),
        Transaction(title: "Courses Carrefour", amount: 85.00, category: .Alimentation, type: .depense, date: "18/06/2026"),
        Transaction(title: "Netflix", amount: 14.00, category: .Loisirs, type: .depense, date: "17/06/2026"),
        Transaction(title: "Vente occasion", amount: 50.00, category: .Autre, type: .revenu, date: "16/06/2026"),
        Transaction(title: "Loyer", amount: 800.00, category: .Logement, type: .depense, date: "01/07/2026"),
        Transaction(title: "Remboursement Resto", amount: 30.00, category: .Virement, type: .revenu, date: "01/07/2026"),
        Transaction(title: "Navigo", amount: 90.00, category: .Transport, type: .depense, date: "01/07/2026"),
        Transaction(title: "Cinéma", amount: 15.00, category: .Loisirs, type: .depense, date: "03/07/2026")
    ]

    static let conseils: [Conseils] = [
        Conseils(title: "Beaucoup de dépenses", message: "Essayez de réduire vos dépenses cette semaine."),
        Conseils(title: "Solde positif", message: "Bonne gestion de votre budget."),
        Conseils(title: "Aucune transaction", message: "Ajoutez une première transaction pour commencer."),
        Conseils(title: "Dépenses supérieures aux revenus", message: "Attention, votre budget est négatif.")
    ]
}
