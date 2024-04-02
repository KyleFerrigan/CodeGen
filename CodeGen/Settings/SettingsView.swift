//
//  SettingsView.swift
//  CodeGen
//
//  Created by Kyle Ferrigan on 3/27/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List{
            Section{
                NavigationLink(destination: AppIconView()) {
                    Text("Change App Icon")
                }
                NavigationLink(destination: AccentColorView()) {
                    Text("Change Accent Color")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView()
}


