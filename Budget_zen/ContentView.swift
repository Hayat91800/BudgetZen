//
//  ContentView.swift
//  Budget_zen
//
//  Created by apprenant144 on 30/06/2026.
//

import SwiftUI

struct ContentView: View {
    @Environment(ViewModel.self) private var vm
    
    var soldeRestant: Double {
        vm.arrOfAllTransaction.reduce(0.0) {
            result, transaction in
            result + transaction.amount
        }
    }
    
    var revenus: Double {
        vm.arrOfAllTransaction.reduce(0.0) {
            result, transaction in
            if transaction.amount > 0 {
                return result + transaction.amount
            } else {
                return result
            }
        }
    }
    
    var depenses: Double {
        vm.arrOfAllTransaction.reduce(0.0) {
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
                    
                    Text(message)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundStyle(.zenText)
                        .padding()
                    
                    CardDashboardView(
                        title: "Solde Restant",
                        value: "\(soldeRestant) €",
                        valueColor: soldeRestant >= 0 ? .green : .red)
                    
                    CardDashboardView(
                        title: "Revenus",
                        value: "\(revenus) €",
                        valueColor: .zenRevenu)
                    
                    CardDashboardView(
                        title: "Dépenses",
                        value: "\(depenses) €",
                        valueColor: .zenDepenses)
                    
                    CardDashboardView(
                        title: "Nombres de transaction",
                        value: "\(vm.arrOfAllTransaction.count)",
                        valueColor: .black)
                    
                    Text("Conseils")
                    
                }
                .padding()
            }
            .background(.zenBackgroundApp)
        }
    }
}

#Preview {
    ContentView()
        .environment(ViewModel())
}
