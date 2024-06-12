//
//  AppIconView.swift
//  CodeGen
//
//  Created by Kyle Ferrigan on 3/28/24.
//

import SwiftUI

struct AppIconView: View {
    @State var iconName : String = String(UIApplication.shared.alternateIconName ?? "Default")
    
    var body: some View {
        // MARK: Icon List
        List {
            Section("Icons"){
                
                // Default
                HStack{
                    Image("Preview-Dynamic")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 35.0)
                        .clipShape(.rect(cornerRadius: 5))
                    Button(
                        action: {
                            resetIcon()
                            self.iconName = getIconName()
                            print("Default Icon Button tapped!")
                        }
                    ){
                        Text("Dynamic (Default)")
                    }
                }
                .padding(0.6)
                
                
                
                // OLED
                HStack{
                    Image("Preview-OLED")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 35.0)
                        .clipShape(.rect(cornerRadius: 5))
                    
                    Button(
                        action: {
                            changeIcon(iconName: "AppIcon-OLED")
                            self.iconName = getIconName()
                            print("OLED Button tapped!")
                        }
                    ){
                        Text("OLED")
                    }
                } 
                .padding(0.6)
                
                // Eclipse
                HStack{
                    Image("Preview-Eclipse")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 35.0)
                        .clipShape(.rect(cornerRadius: 5))
                    
                    Button(
                        action: {
                            changeIcon(iconName: "AppIcon-Eclipse")
                            self.iconName = getIconName()
                            print("Eclipse Button tapped!")
                        }
                    ){
                        Text("Eclipse")
                    }
                }
                .padding(0.6)
                
                // Light
                HStack{
                    Image("Preview-Light")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 35.0)
                        .clipShape(.rect(cornerRadius: 5))
                    
                    Button(
                        action: {
                            changeIcon(iconName: "AppIcon-Light")
                            self.iconName = getIconName()
                            print("Light Button tapped!")
                        }
                    ){
                        Text("Light")
                    }
                }
                .padding(0.6)
               
                // Classic QR
                HStack{
                    Image("Preview-Classic")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 35.0)
                        .clipShape(.rect(cornerRadius: 5))
                    
                    Button(
                        action: {
                            changeIcon(iconName: "AppIcon-Classic")
                            self.iconName = getIconName()
                            print("Classic QR Button tapped!")
                        }
                    ){
                        Text("Classic")
                    }
                }
                .padding(0.6)
                
                
                // Blueberry
                HStack{
                    Image("Preview-Blueberry")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 35.0)
                        .clipShape(.rect(cornerRadius: 5))
                    
                    Button(
                        action: {
                            changeIcon(iconName: "AppIcon-Blueberry")
                            self.iconName = getIconName()
                            print("Blueberry Button tapped!")
                        }
                    ){
                        Text("Blueberry")
                    }
                }
                .padding(0.6)
                
                // Best Buy
                HStack{
                    Image("Preview-BBY")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 35.0)
                        .clipShape(.rect(cornerRadius: 5))
                    
                    Button(
                        action: {
                            changeIcon(iconName: "AppIcon-BBY")
                            self.iconName = getIconName()
                            print("Best Bargain Button tapped!")
                        }
                    ){
                        Text("Best Bargain")
                    }
                }
                .padding(0.6)
                
            }
            #if DEBUG
            //MARK: Debug Section
            Section("Debug"){
                Text("Device supports icon change: " + String(UIApplication.shared.supportsAlternateIcons))
                Text("Current app icon: " + iconName)
            }
            #endif
        }
        .navigationTitle("App Icons")
        .navigationBarTitleDisplayMode(.inline)
    }
    //MARK: Change Icon Function
    func changeIcon(iconName:String){
        if UIApplication.shared.supportsAlternateIcons {
            // Set a new alternate icon
            UIApplication.shared.setAlternateIconName(iconName) { error in
                if let error = error {
                    print("Error setting alternate icon: \(error.localizedDescription)")
                } else {
                    print("Icon changed successfully!")
                }
            }
        }
        else {
          // Handle devices that don't support alternate icons
          print("Alternate icons not supported on this device")
        }
    }

    func resetIcon(){
        if UIApplication.shared.supportsAlternateIcons {
            // Set a new alternate icon
            UIApplication.shared.setAlternateIconName(nil) { error in
                if let error = error {
                    print("Error setting alternate icon: \(error.localizedDescription)")
                } else {
                    print("Icon changed successfully!")
                }
            }
        }
        else {
          // Handle devices that don't support alternate icons
          print("Alternate icons not supported on this device")
        }
    }
    
    func getIconName() -> String{
        return String(UIApplication.shared.alternateIconName ?? String("Default"))
    }
}

#Preview {
    AppIconView()
}
