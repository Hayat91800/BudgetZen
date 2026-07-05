//
//  DashboardView.swift
//  Budget_zen
//
//  Created by apprenant144 on 03/07/2026.
//

import SwiftUI

struct DashboardView: View {
    
    @Environment(ViewModel.self) private var viewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 20){
                    Text("Budget Zen")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    HStack {
                        Text("Bienvenue Hayat")
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
    
                    }
                    
                    Text(viewModel.message)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundStyle(.zenText)
                        .padding()
                    
                    CardDashboardView(
                        title: "Solde Restant",
                        value: "\(viewModel.soldeRestant) €",
                        valueColor: viewModel.soldeRestant >= 0 ? .green : .red)
                    
                    CardDashboardView(
                        title: "Revenus",
                        value: "\(viewModel.revenus) €",
                        valueColor: .zenRevenu)
                    
                    CardDashboardView(
                        title: "Dépenses",
                        value: "\(viewModel.depenses) €",
                        valueColor: .zenDepenses)
                    
                    CardDashboardView(
                        title: "Nombres de transaction",
                        value: "\(viewModel.data.arrOfAllTransaction.count)",
                        valueColor: .black)
                    
                    Text("Conseils")
                    
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    DashboardView()
        .environment(ViewModel())
}
