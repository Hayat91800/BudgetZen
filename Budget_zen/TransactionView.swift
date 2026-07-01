//
//  DashboardView.swift
//  Budget_zen
//
//  Created by apprenant144 on 01/07/2026.
//

import SwiftUI

struct TransactionView: View {
    @Environment(ViewModel.self) private var vm
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TransactionView()
        .environment(ViewModel())
}
