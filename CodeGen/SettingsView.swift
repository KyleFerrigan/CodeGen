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
                        .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
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


