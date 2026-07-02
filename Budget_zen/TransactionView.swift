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
    @State private var selectedCategory: Category = .Alimentation
    @State private var selectedFilter = 0
    
    var onAjout: (Transaction) -> Void = { _ in }
    
    private var filteredCategories: [Category] {
        Category.allCases.filter {$0.revenu == (selectedFilter == 2)}
    }
    
    var results: [Transaction] {
        let typeFiltered = vm.arrOfAllTransaction.filter { transaction in
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
    
    var body: some View {
        
        NavigationStack{
            VStack (spacing: 0){
                Section {
                    Picker("Type de transaction", selection: $selectedFilter){
                        Text("Tout").tag(0)
                        Text("Dépense").tag(1)
                        Text("Renevu").tag(2)
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .background(Color(.systemGroupedBackground))
                    .onChange(of: selectedFilter) { _, newValue in
                        selectedCategory = .Alimentation}
                }
                
                List {
                    ForEach(results) { transaction in
                        
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
                            return 0 } // Aligne le separateur sur le bord avant 
                    }
                }
            }
                .navigationTitle("Transaction")
                .searchable(text: $research, placement: .navigationBarDrawer(displayMode: .always), prompt:"Rechercher une transaction")
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
