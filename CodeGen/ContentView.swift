//
//  ContentView.swift
//  CodeGen
//
//  Created by Kyle Ferrigan on 3/8/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var textIn: String = ""
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [QRCode]
    @State private var type = ["Standard", "Email",  "Call", "SMS"]
    //@State private var selectedType: String = "Standard"
    @State private var selectedType: Int = 0

    var body: some View {
        //Keeps track if current QR Code has been favorited or not
        @State var favorited: Bool = checkFavorited(items: self.items, textIn: self.textIn)
        
        NavigationStack {
            //MARK: Main View
            List {
                Section{
                    if (self.selectedType == 0){ // Standard
                        Image(uiImage: generateQRCode(from: textIn))
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .contextMenu{
                                    let image = generateQRCode(from: textIn)
                                    let scaledimage = image.scalePreservingAspectRatio(targetSize: CGSize(width: 1000, height: 1000))
                                    
                                    ShareLink(item: Image(uiImage: scaledimage), preview: SharePreview("My QR Code", image: Image(uiImage: image)))
                            }
                    }
                    if (self.selectedType == 1){ // Email
                        Image(uiImage: generateQRCode(from: "mailto:"+textIn))
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .contextMenu{
                                    let image = generateQRCode(from: "mailto:"+textIn)
                                    let scaledimage = image.scalePreservingAspectRatio(targetSize: CGSize(width: 1000, height: 1000))
                                    
                                    ShareLink(item: Image(uiImage: scaledimage), preview: SharePreview("My QR Code", image: Image(uiImage: image)))
                            }
                    }
                    if (self.selectedType == 2){ // Call
                        Image(uiImage: generateQRCode(from: "tel:"+textIn))
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .contextMenu{
                                    let image = generateQRCode(from: "tel:"+textIn)
                                    let scaledimage = image.scalePreservingAspectRatio(targetSize: CGSize(width: 1000, height: 1000))
                                    
                                    ShareLink(item: Image(uiImage: scaledimage), preview: SharePreview("My QR Code", image: Image(uiImage: image)))
                            }
                    }
                    if (self.selectedType == 3){ // SMS
                        Image(uiImage: generateQRCode(from: "sms:"+textIn))
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .contextMenu{
                                    let image = generateQRCode(from: "sms:"+textIn)
                                    let scaledimage = image.scalePreservingAspectRatio(targetSize: CGSize(width: 1000, height: 1000))
                                    
                                    ShareLink(item: Image(uiImage: scaledimage), preview: SharePreview("My QR Code", image: Image(uiImage: image)))
                            }
                    }
                    

                    Picker("QR Code Action", selection: $selectedType){
                        ForEach(0..<type.count, id: \.self) {
                            Text(self.type[$0])
                        }
                    }
                    .pickerStyle(.menu)
                    TextField("Type contents of QR code here", text: $textIn)
                        .autocorrectionDisabled()
                        .keyboardType(.asciiCapable)
                        .autocapitalization(.none)
                }
                NavigationLink(destination: FavoritesView()) {
                    Text("Favorited QR Codes")
                }
            }
            
            //MARK: Navigation Toolbar
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gear")
                        }
                }
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button(
                        action: {
                            
                            print("Favorite Button tapped!")
                            print(modelContext.container)
                            print(modelContext.hasChanges)
                            if (self.selectedType == 0){ // Standard
                                modelContext.insert(QRCode(data: textIn))
                            } else if (self.selectedType == 1){ // Email
                                modelContext.insert(QRCode(data: "mailto:"+textIn))
                            } else if (self.selectedType == 2){ // Call
                                modelContext.insert(QRCode(data: "tel:"+textIn))
                            } else if (self.selectedType == 3){ // SMS
                                modelContext.insert(QRCode(data: "sms:"+textIn))
                            }
                            print(modelContext.hasChanges)

                            do {
                                try modelContext.save()
                                print(modelContext.hasChanges)
                            } catch {
                                print("Could not save context after fav")
                            }
                        }
                    ){
                        Label("Favorite", systemImage: favorited ? "star.circle.fill" : "star.circle")
                    }
                }
            }
            .navigationTitle("CodeGen")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

func checkFavorited(items: [QRCode], textIn: String) -> Bool{
    for item in items {
        if (item.data == textIn){
            return true
        }
    }
    return false
}

#Preview {
    ContentView()
        .modelContainer(for: QRCode.self, inMemory: true)
    
}
