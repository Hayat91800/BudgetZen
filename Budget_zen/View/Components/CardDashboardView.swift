//
//  CardDashboardView.swift
//  Budget_zen
//
//  Created by apprenant144 on 01/07/2026.
//

import SwiftUI

struct CardDashboardView: View {
    let title: String
    let value: String
    var valueColor: Color = .white
    
    var body: some View {
        VStack(spacing:8) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.zenText.opacity(0.8))
            
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(valueColor)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.zenBackgroundCard)
        .cornerRadius(22)
    }
}


