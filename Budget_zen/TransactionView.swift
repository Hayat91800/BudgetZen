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
    var onAjout: (Transaction) -> Void = { _ in }
    
    var body: some View {

        NavigationStack{
    
            List {
                    ForEach(vm.arrOfAllTransaction) {transaction in
                        
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
