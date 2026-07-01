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
    
    var color: Color {
        switch self {
        case .Salaire, .Virement, .Cadeaux:
            return .green
        case .Alimentation, .Logement, .Transport:
            return .red
        case .Loisirs, .Autre:
            return .orange
        }
    }
    
    var revenu: Bool {
        switch self {
        case .Salaire, .Virement, .Cadeaux:
            return true
        case .Alimentation, .Logement, .Transport, .Loisirs, .Autre:
            return false
        }
    }
    
    var icon: String{
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
