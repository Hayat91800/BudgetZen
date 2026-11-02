//
//  ViewModel.swift
//  Budget_zen
//
//  Created by apprenant144 on 03/07/2026.
//

import SwiftUI
import Observation

/// Filtre de la liste des transactions (Fonctionnalité 5)
enum FiltreTransaction: String, CaseIterable, Hashable {
    case toutes = "Toutes"
    case revenus = "Revenus"
    case depenses = "Dépenses"
}

@Observable
final class ViewModel {

    /// Tableau de toutes les transactions (stockées uniquement en mémoire)
    var transactions: [Transaction] = MockData.transactions

    // MARK: - Tableau de bord (Fonctionnalité 1)

    /// Calcule le total des revenus
    func totalRevenus(_ transactions: [Transaction]) -> Double {
        var total = 0.0
        for transaction in transactions where transaction.type == .revenu {
            total += transaction.amount
        }
        return total
    }

    /// Calcule le total des dépenses (valeur positive)
    func totalDepenses(_ transactions: [Transaction]) -> Double {
        var total = 0.0
        for transaction in transactions where transaction.type == .depense {
            total += transaction.amount
        }
        return total
    }

    /// Solde = total des revenus - total des dépenses
    func solde(_ transactions: [Transaction]) -> Double {
        return totalRevenus(transactions) - totalDepenses(transactions)
    }

    /// Retourne un message selon la valeur du solde
    func messageSolde(_ solde: Double) -> String {
        if solde > 0 {
            return "Votre budget est positif."
        } else if solde < 0 {
            return "Attention, vos dépenses dépassent vos revenus."
        } else {
            return "Votre budget est équilibré."
        }
    }

    // MARK: - Ajout d'une transaction (Fonctionnalité 3)

    /// Vérifie les champs du formulaire.
    /// Retourne un message d'erreur, ou nil si tout est correct.
    func validerTransaction(title: String, amount: Double?, category: Category?, type: TransactionType?, date: String) -> String? {
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Le titre ne doit pas être vide."
        }
        guard let amount, amount > 0 else {
            return "Le montant doit être supérieur à 0."
        }
        if type == nil {
            return "Veuillez sélectionner un type (revenu ou dépense)."
        }
        if category == nil {
            return "Veuillez choisir une catégorie."
        }
        if date.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "La date ne doit pas être vide."
        }
        return nil
    }

    /// Ajoute une transaction dans le tableau : la liste et les calculs se mettent à jour automatiquement
    func ajouterTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
    }

    /// Bonus : supprimer une transaction
    func supprimerTransaction(_ transaction: Transaction) {
        transactions.removeAll { $0.id == transaction.id }
    }

    // MARK: - Recherche et filtre (Fonctionnalités 4 et 5)

    var research = ""
    var selectedFilter: FiltreTransaction = .toutes

    /// Retourne vrai si le titre contient le texte recherché (sans tenir compte des majuscules / minuscules)
    func correspondALaRecherche(_ transaction: Transaction, texte: String) -> Bool {
        if texte.isEmpty {
            return true
        }
        return transaction.title.lowercased().contains(texte.lowercased())
    }

    /// Retourne vrai si la transaction correspond au filtre choisi
    func correspondAuFiltre(_ transaction: Transaction, filtre: FiltreTransaction) -> Bool {
        switch filtre {
        case .toutes: return true
        case .revenus: return transaction.type == .revenu
        case .depenses: return transaction.type == .depense
        }
    }

    /// Transactions filtrées : la recherche et le filtre fonctionnent ensemble
    func transactionsFiltrees() -> [Transaction] {
        var resultat: [Transaction] = []
        for transaction in transactions {
            if correspondAuFiltre(transaction, filtre: selectedFilter) && correspondALaRecherche(transaction, texte: research) {
                resultat.append(transaction)
            }
        }
        return resultat
    }

    // MARK: - Statistiques (Fonctionnalité 6)

    func countAllTransaction(_ transactions: [Transaction]) -> Int {
        return transactions.count
    }

    func countAllRevenus(_ transactions: [Transaction]) -> Int {
        var compteur = 0
        for transaction in transactions where transaction.type == .revenu {
            compteur += 1
        }
        return compteur
    }

    func countAllDepenses(_ transactions: [Transaction]) -> Int {
        var compteur = 0
        for transaction in transactions where transaction.type == .depense {
            compteur += 1
        }
        return compteur
    }

    /// Trouve le revenu avec le montant le plus élevé (nil s'il n'y a aucun revenu)
    func plusGrandRevenu(_ transactions: [Transaction]) -> Transaction? {
        var plusGrand: Transaction? = nil
        for transaction in transactions where transaction.type == .revenu {
            if plusGrand == nil || transaction.amount > plusGrand!.amount {
                plusGrand = transaction
            }
        }
        return plusGrand
    }

    /// Trouve la dépense avec le montant le plus élevé (nil s'il n'y a aucune dépense)
    func plusGrandeDepense(_ transactions: [Transaction]) -> Transaction? {
        var plusGrande: Transaction? = nil
        for transaction in transactions where transaction.type == .depense {
            if plusGrande == nil || transaction.amount > plusGrande!.amount {
                plusGrande = transaction
            }
        }
        return plusGrande
    }

    /// Moyenne des dépenses = total des dépenses / nombre de dépenses (0 s'il n'y a aucune dépense)
    func averageDepense(_ transactions: [Transaction]) -> Double {
        let nombre = countAllDepenses(transactions)
        if nombre == 0 {
            return 0
        }
        return totalDepenses(transactions) / Double(nombre)
    }

    /// Trouve la catégorie qui revient le plus souvent
    func mostUseCategory(_ transactions: [Transaction]) -> String {
        if transactions.isEmpty {
            return "Aucune"
        }

        var compteurs: [Category: Int] = [:]
        for transaction in transactions {
            compteurs[transaction.category, default: 0] += 1
        }

        var meilleure: Category? = nil
        var maximum = 0
        for category in Category.allCases {        // ordre fixe pour un résultat stable en cas d'égalité
            let nombre = compteurs[category] ?? 0
            if nombre > maximum {
                maximum = nombre
                meilleure = category
            }
        }
        return meilleure?.rawValue ?? "Aucune"
    }

    /// Bonus : nombre de transactions par catégorie
    func nombreParCategorie(_ transactions: [Transaction]) -> [(category: Category, nombre: Int)] {
        var resultat: [(category: Category, nombre: Int)] = []
        for category in Category.allCases {
            let nombre = transactions.filter { $0.category == category }.count
            if nombre > 0 {
                resultat.append((category, nombre))
            }
        }
        return resultat
    }

    // MARK: - Conseil (Fonctionnalité 7)

    /// Retourne un conseil simple selon les données de l'utilisateur
    func conseil(_ transactions: [Transaction]) -> String {
        let revenus = totalRevenus(transactions)
        let depenses = totalDepenses(transactions)

        if transactions.isEmpty {
            return "Ajoutez une première transaction pour commencer."
        } else if depenses > revenus {
            return "Attention, votre budget est négatif."
        } else if depenses >= revenus * 0.8 {
            // Beaucoup de dépenses : au moins 80 % des revenus sont dépensés
            return "Essayez de réduire vos dépenses cette semaine."
        } else {
            return "Bonne gestion de votre budget."
        }
    }
}
