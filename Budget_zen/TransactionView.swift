//
//  DashboardView.swift
//  Budget_zen
//
//  Created by apprenant144 on 01/07/2026.
//

import SwiftUI

struct TransactionView: View {
    @Environment(ViewModel.self) private var vm
    @Environment(\.dismiss) private var dismiss
    
    @State private var ajout = false
    @State private var research = ""
    
    var onAjout: (Transaction) -> Void = { _ in }
    
    var results: [Transaction] {
        if research.isEmpty {
            return vm.arrOfAllTransaction
        } else {
            return vm.arrOfAllTransaction.filter { transaction in
                transaction.title.localizedCaseInsensitiveContains(research)
                // localizedCaseInsensitiveContains: insensible a la casse
            }
        }
    }
    
    var body: some View {

        NavigationStack{
    
            List {
                    ForEach(results) {transaction in
                        
                        HStack(spacing: 24) {
                            
                            Image(systemName: transaction.category.icon)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .frame(width: 40, height: 40)
                                .foregroundStyle(transaction.category.color)
                            
                            VStack(alignment: .leading) {

                                Text(transaction.title)
                                .font(.title3)
                                .foregroundStyle(.black)
                                
                                Text(transaction.category.rawValue)
                            }
                            
                            Spacer()
                            
                            Text(String(transaction.amount))
                                .foregroundStyle(transaction.category.color)
                            
                        }
                        .alignmentGuide(.listRowSeparatorLeading) { _ in
                            return 0 // Aligne le separateur sur le bord avant
                        }
                    }

                }
                .navigationTitle("Transaction")
                .searchable(text: $research, prompt:"Rechercher une transaction")
                .textInputAutocapitalization(.never) // Empêche la majuscule automatique
                
                .toolbar {
                    ToolbarItem (placement: .topBarTrailing) {
                        Button {
                            ajout = true
                        } label: {
                            Label("Ajout", systemImage: "plus.circle.fill")
                        }
                        .sheet(isPresented: $ajout) {
                            AjoutFormView {newTransaction in
                                vm.arrOfAllTransaction.append(newTransaction)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.top)
                    }
                }
            }
        }
}

#Preview {
    TransactionView()
        .environment(ViewModel())
}
