//
//  ViewModel.swift
//  Budget_zen
//
//  Created by apprenant144 on 03/07/2026.
//

import SwiftUI
import Observation

@Observable

final class ViewModel {
    
    var data = MockData()
    
// DashboardView
    
    var soldeRestant: Double {
        data.arrOfAllTransaction.reduce(0.0) {
            result, transaction in
            result + transaction.amount
        }
    }
    
    var revenus: Double {
        data.arrOfAllTransaction.reduce(0.0) {
            result, transaction in
            if transaction.amount > 0 {
                return result + transaction.amount
            } else {
                return result
            }
        }
    }
    
    var depenses: Double {
        data.arrOfAllTransaction.reduce(0.0) {
            result, transaction in
            if transaction.amount < 0 {
                return result + transaction.amount
            } else {
                return result
            }
        }
    }
    
    var message: String {
        if soldeRestant > 0 {
            return "Votre budget est positif."
        } else if soldeRestant < 0 {
            return "Attention, vos dépenses dépassent vos revenus."
        } else {
            return "Votre budget est équilibré."
        }
    }
    
    
// TransactionView
    
    var ajout = false
    var research = ""
    var selectedCategory: Category = .Alimentation
    var selectedFilter = 0
    
    var onAjout: (Transaction) -> Void = { _ in }
    
    var filteredCategories: [Category] {
        Category.allCases.filter {$0.revenu == (selectedFilter == 2)}
    }
    
    var results: [Transaction] {
        let typeFiltered = data.arrOfAllTransaction.filter { transaction in
            switch selectedFilter {
            case 1: return transaction.amount < 0 // Dépense
            case 2: return transaction.amount > 0 // Revenu
            default: return true // Toutes les transactions
            }
        }
        
        if research.isEmpty {
            return typeFiltered
        } else {
            return typeFiltered.filter { transaction in
                transaction.title.localizedCaseInsensitiveContains(research)
                // localizedCaseInsensitiveContains: insensible a la casse
            }
        }
        
        
    }
    
// StatiscticView
    
    
    
}
