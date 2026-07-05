//
//  AjoutFormView.swift
//  Budget_zen
//
//  Created by apprenant144 on 01/07/2026.
//

import SwiftUI

struct AjoutFormView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var amount: Double? = nil
    @State private var selectedCategory: Category = .Alimentation
    @State private var date = Date()
    @State private var isRevenu = false
    
    var onAjout: (Transaction) -> Void
    
    private var filteredCategories: [Category] {
        Category.allCases.filter {$0.revenu == isRevenu}
    }
    
    let dateFormatter: DateFormatter = {
        let dateString = DateFormatter()
        dateString.dateFormat = "dd/MM/yyyy"
        return dateString
    }()
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Type de transaction", selection: $isRevenu){
                        Text("Dépense").tag(false)
                        Text("Renevu").tag(true)
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: isRevenu) { _, newValue in
                        selectedCategory = newValue ? .Salaire : .Alimentation}
                }
                
                Section (header: Text("Détails de la transaction")) {
                    TextField ("Titre (ex: Courses Carrefour)", text: $title)
                    TextField ("Montant (€)", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                Section (header: Text("Categorie & Date")) {
                    Picker("Categorie", selection: $selectedCategory) {
                        ForEach(filteredCategories, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    
                    DatePicker ("Date", selection: $date, displayedComponents: .date)
                }
            }
            .navigationTitle("Nouvelle transaction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button("Annuler") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Ajouter") {
                        let finalAmount = amount ?? 0.0
                        let signedAmount = isRevenu ? finalAmount : -finalAmount
                        let newTransaction = Transaction (
                            title: title,
                            amount: signedAmount,
                            category: selectedCategory,
                            date: dateFormatter.string(from: date)
                        )
                        onAjout(newTransaction)
                        dismiss()
                    }
                    .disabled(
                        // trimmingCharacters(in: .whitespacesAndNewlines): supprime tout les espaces et retours a la ligne avant de checker isEmpty
                        title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || amount == nil || (amount ?? 0.0) <= 0
                    )
                }
                
            }
        }
    }
}

#Preview {
    AjoutFormView(onAjout: { _ in })
}
