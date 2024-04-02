//
//  AccentColorView.swift
//  CodeGen
//
//  Created by Kyle Ferrigan on 3/31/24.
//

import SwiftUI

struct AccentColorView: View {
    @AppStorage("userAccentChoice") var userAccentChoice: Int = 0
    
    var body: some View {
        List{
            Button(
                action: {
                    userAccentChoice = 1
                    print("Red Button tapped!")
                }
            ){
                Text("Red")
            }
            Button(
                action: {
                    userAccentChoice = 2
                    print("Green Button tapped!")
                }
            ){
                Text("Green")
            }
            Button(
                action: {
                    userAccentChoice = 3
                    print("Blue Button tapped!")
                }
            ){
                Text("Blue")
            }
            Button(
                action: {
                    userAccentChoice = 4
                    print("Teal Button tapped!")
                }
            ){
                Text("Teal")
            }
            Button(
                action: {
                    userAccentChoice = 5
                    print("Pink Button tapped!")
                }
            ){
                Text("Pink")
            }
            Button(
                action: {
                    userAccentChoice = 6
                    print("Mint Button tapped!")
                }
            ){
                Text("Mint")
            }
        }
        .navigationTitle("AccentColor")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AccentColorView()
}
