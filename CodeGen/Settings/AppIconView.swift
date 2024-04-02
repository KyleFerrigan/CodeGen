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
                
                //Default
                Button(
                    action: {
                        resetIcon()
                        self.iconName = getIconName()
                        print("Default Icon Button tapped!")
                    }
                ){
                    Text("Default")
                }
                
                //Light
                Button(
                    action: {
                        changeIcon(iconName: "AppIcon-Teal-Light")
                        self.iconName = getIconName()
                        print("Light Button tapped!")
                    }
                ){
                    Text("Light")
                }
                
                //OLED
                Button(
                    action: {
                        changeIcon(iconName: "AppIcon-Teal-OLED")
                        self.iconName = getIconName()
                        print("OLED Button tapped!")
                    }
                ){
                    Text("OLED")
                }
                
                //Classic QR
                Button(
                    action: {
                        changeIcon(iconName: "AppIcon-Classic")
                        self.iconName = getIconName()
                        print("Classic QR Button tapped!")
                    }
                ){
                    Text("Classic QR")
                }
                
                //Midnight
                Button(
                    action: {
                        changeIcon(iconName: "AppIcon-OLED")
                        self.iconName = getIconName()
                        print("Midnight Button tapped!")
                    }
                ){
                    Text("Midnight")
                }
                
                //Blueberry
                Button(
                    action: {
                        changeIcon(iconName: "AppIcon-Blueberry")
                        self.iconName = getIconName()
                        print("Blueberry Button tapped!")
                    }
                ){
                    Text("Blueberry")
                }
                
                //Best Buy
                Button(
                    action: {
                        changeIcon(iconName: "AppIcon-BBY")
                        self.iconName = getIconName()
                        print("Premier Purchase Button tapped!")
                    }
                ){
                    Text("Premier Purchase")
                }
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
