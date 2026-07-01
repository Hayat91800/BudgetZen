//
//  Transactions.swift
//  Budget_zen
//
//  Created by apprenant144 on 30/06/2026.
//

import Foundation
import SwiftUI

struct Transaction: Identifiable, Hashable {
    
    var id = UUID()
    var title: String
    var amount: Double
    var category: Category
    var date:String
}

