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
                    print("Orange Button tapped!")
                }
            ){
                Text("Orange")
            }
            Button(
                action: {
                    userAccentChoice = 5
                    print("Purple Button tapped!")
                }
            ){
                Text("Purple")
            }
            Button(
                action: {
                    userAccentChoice = 6
                    print("Yellow Button tapped!")
                }
            ){
                Text("Yellow")
            }
            Button(
                action: {
                    userAccentChoice = 7
                    print("Mint Button tapped!")
                }
            ){
                Text("Mint")
            }
            Button(
                action: {
                    userAccentChoice = 8
                    print("Gray Button tapped!")
                }
            ){
                Text("Gray")
            }
        }
        .navigationTitle("AccentColor")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AccentColorView()
}
