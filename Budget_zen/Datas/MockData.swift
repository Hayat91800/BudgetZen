//
//  ViewModel.swift
//  Budget_zen
//
//  Created by apprenant144 on 30/06/2026.
//

import Foundation
import SwiftUI

 @Observable
final class MockData {
    
    var arrOfAllTransaction: [Transaction] = [
        Transaction(
            title: "Salaire Juin",
            amount: 2500.00,
            category: .Salaire,
            date: "28/05/2026"),
        Transaction(
            title: "Courses Carrefour",
            amount: -85.50,
            category: .Alimentation ,
            date: "29/06/2026"),

        Transaction(
            title: "Loyer",
            amount: -800.00,
            category:.Logement,
            date: "01/07/2026"),

        Transaction(
            title: "Remboursement Resto",
            amount: 30.00,
            category: .Virement,
            date: "01/07/2026"),

        Transaction(
            title: "Navigo",
            amount: -90,
            category: .Transport,
            date: "01/07/2026"),

        Transaction(
            title: "Cinéma",
            amount: -15.00,
            category: .Loisirs,
            date: "3/07/2026"),
        Transaction(
            title: "Netflix",
            amount: -15.00,
            category: .Loisirs,
            date: "8/07/2026")
    ]
    
    var arrOfConseil = [
        Conseils(
            title: "Beaucoup de dépenses ",
            message:
                "Essayez de réduire vos dépenses cette semaine."
        ),
        Conseils(
            title: "Solde positif ",
            message:
                "Bonne gestion de votre budget."
        ),
        Conseils(
            title: "Aucune transaction",
            message:
                "Ajoutez une première transaction pour commencer."
        ),
        Conseils(
            title: "Dépenses supérieures aux revenus  ",
            message:
                "Attention, votre budget est négatif."
        ) ]
}
