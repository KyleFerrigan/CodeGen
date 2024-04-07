//
//  ContentView.swift
//  CodeGen
//
//  Created by Kyle Ferrigan on 3/8/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [QRCode]
    
    @State private var type = ["Standard", "Email",  "Call", "SMS"]
    @State private var selectedType: Int = 0
    
    @State var textIn: String = ""

    var body: some View {
        //Keeps track if current QR Code has been favorited or not
        @State var favorited: Bool = checkFavorited(items: self.items, textIn: formatQRData())
        
        NavigationStack {
            //MARK: Main View
            List {
                Section{
                    Image(uiImage: generateQRCode(from: formatQRData()))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .contextMenu{
                                let image = generateQRCode(from: formatQRData())
                                let scaledimage = image.scalePreservingAspectRatio(targetSize: CGSize(width: 1000, height: 1000))
                                
                                ShareLink(item: Image(uiImage: scaledimage), preview: SharePreview("My QR Code", image: Image(uiImage: image)))
                        }
                    Picker("QR Code Action", selection: $selectedType){
                        ForEach(0..<type.count, id: \.self) {
                            Text(self.type[$0])
                        }
                    }
                    .pickerStyle(.menu)
                    TextField("Type contents of QR code here", text: $textIn)
                        .autocorrectionDisabled()
                        .keyboardType(.webSearch)
                        // TODO: Make keyboard type change based on action
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
                    // TODO: make clicking an already favorited QR code delete it from the list
                    Button(
                        action: {
                            #if DEBUG
                            print("Favorite Button tapped!")
                            print(modelContext.container)
                            print(modelContext.hasChanges)
                            print(modelContext.hasChanges)
                            #endif
                            
                            modelContext.insert(QRCode(data: formatQRData()))
                            
                            do {
                                try modelContext.save()
                                print(modelContext.hasChanges)
                            } catch {
                                print("Could not save context after favorite")
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
    // MARK: formatQRCode func
    // TextIn data formatting
    func formatQRData()->String{
        var data: String
        
        if (self.selectedType == 1) { // Email
            data = "mailto:"+self.textIn
        } else if (self.selectedType == 2) { // Call
            data = "tel:"+self.textIn
        } else if (self.selectedType == 3) { // SMS
            data = "sms:"+self.textIn
        } else {
            data = self.textIn
        }
        
        return data
    }
}

// MARK: checkFavorited func
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
