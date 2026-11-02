//
//  AjoutFormView.swift
//  Budget_zen
//
//  Created by apprenant144 on 01/07/2026.
//

import SwiftUI

/// Fonctionnalité 3 – Ajouter une transaction
/// Utilisé dans l'onglet "Ajouter" et dans la feuille ouverte depuis la liste.
struct AjoutFormView: View {

    @Environment(ViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss

    /// true quand le formulaire est présenté en feuille (sheet) : il se ferme après l'ajout
    var fermerApresAjout = false

    // Variables qui récupèrent les saisies
    @State private var title = ""
    @State private var amount: Double? = nil
    @State private var type: TransactionType? = nil
    @State private var selectedCategory: Category? = nil
    @State private var date = Date()

    // Messages affichés à l'utilisateur
    @State private var messageErreur: String? = nil
    @State private var messageSucces: String? = nil

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()

    private var categoriesDisponibles: [Category] {
        guard let type else { return Category.allCases }
        return Category.categories(pour: type)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Type") {
                    Picker("Type de transaction", selection: $type) {
                        Text("Revenu").tag(Optional(TransactionType.revenu))
                        Text("Dépense").tag(Optional(TransactionType.depense))
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: type) { _, _ in
                        // La catégorie choisie doit rester cohérente avec le type
                        if let selectedCategory, !categoriesDisponibles.contains(selectedCategory) {
                            self.selectedCategory = nil
                        }
                    }
                }

                Section("Détails de la transaction") {
                    TextField("Titre (ex : Courses Carrefour)", text: $title)
                    TextField("Montant (€)", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                }

                Section("Catégorie & Date") {
                    Picker("Catégorie", selection: $selectedCategory) {
                        Text("Choisir…").tag(Category?.none)
                        ForEach(categoriesDisponibles, id: \.self) { category in
                            Label(category.rawValue, systemImage: category.icon)
                                .tag(Optional(category))
                        }
                    }

                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }

                if let messageErreur {
                    Section {
                        Label(messageErreur, systemImage: "exclamationmark.triangle.fill")
                            .foregroundStyle(.red)
                    }
                }

                if let messageSucces {
                    Section {
                        Label(messageSucces, systemImage: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                    }
                }

                Section {
                    Button {
                        ajouter()
                    } label: {
                        Text("Ajouter la transaction")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .listRowBackground(Color.clear)
                }
            }
            .navigationTitle("Nouvelle transaction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if fermerApresAjout {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Annuler") { dismiss() }
                    }
                }
            }
        }
    }

    /// Récupère les valeurs, valide, crée la transaction et l'ajoute au tableau
    private func ajouter() {
        let dateTexte = dateFormatter.string(from: date)

        if let erreur = viewModel.validerTransaction(title: title, amount: amount, category: selectedCategory, type: type, date: dateTexte) {
            messageErreur = erreur
            messageSucces = nil
            return
        }

        // Ici la validation garantit que les valeurs ne sont pas nil
        guard let amount, let type, let selectedCategory else { return }

        let nouvelleTransaction = Transaction(
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            amount: amount,
            category: selectedCategory,
            type: type,
            date: dateTexte
        )

        withAnimation {
            viewModel.ajouterTransaction(nouvelleTransaction)
        }

        if fermerApresAjout {
            dismiss()
        } else {
            // Bonus : message de réussite puis remise à zéro du formulaire
            messageErreur = nil
            messageSucces = "« \(nouvelleTransaction.title) » a bien été ajoutée."
            reinitialiser()
        }
    }

    private func reinitialiser() {
        title = ""
        amount = nil
        type = nil
        selectedCategory = nil
        date = Date()
    }
}

#Preview {
    AjoutFormView()
        .environment(ViewModel())
}
