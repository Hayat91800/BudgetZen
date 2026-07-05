//
//  DashboardView.swift
//  Budget_zen
//
//  Created by apprenant144 on 01/07/2026.
//

import SwiftUI

struct TransactionView: View {
    @Environment(ViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        @Bindable var viewModel = viewModel
        
        NavigationStack{
            VStack (spacing: 0){
                Section {
                    Picker("Type de transaction", selection: $viewModel.selectedFilter){
                        Text("Tout").tag(0)
                        Text("Dépense").tag(1)
                        Text("Renevu").tag(2)
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .background(Color(.systemGroupedBackground))
                    .onChange(of: viewModel.selectedFilter) { _, newValue in
                        viewModel.selectedCategory = .Alimentation}
                }
                
                List {
                    ForEach(viewModel.results) { transaction in
                        
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
                .searchable(text: $viewModel.research, placement: .navigationBarDrawer(displayMode: .always), prompt:"Rechercher une transaction")
                .textInputAutocapitalization(.never) // Empêche la majuscule automatique
                .toolbar {
                    ToolbarItem (placement: .topBarTrailing) {
                        Button {
                            viewModel.ajout = true
                        } label: {
                            Label("Ajout", systemImage: "plus.circle.fill")
                        }
                        .sheet(isPresented: $viewModel.ajout) {
                            AjoutFormView {newTransaction in
                                viewModel.data.arrOfAllTransaction.append(newTransaction)
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
