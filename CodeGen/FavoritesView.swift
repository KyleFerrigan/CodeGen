//
//  FavoritesView.swift
//  CodeGen
//
//  Created by Kyle Ferrigan on 3/27/24.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        List{
            Text("Favorite QR Codes will displayed here as a list")
        }
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FavoritesView()
}
