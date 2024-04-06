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

    var body: some View {
        NavigationStack {
            //MARK: Main View
            List {
                Section{
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
                    
                    TextField("Type contents of QR code here", text: $textIn)
                        .autocorrectionDisabled()
                        .keyboardType(.asciiCapable)
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
                            modelContext.insert(QRCode(data: textIn))
                            print(modelContext.hasChanges)

                            do {
                                try modelContext.save()
                                print(modelContext.hasChanges)
                            } catch {
                                print("Could not save context after fav")
                            }
                        }
                    ){
                        Label("Favorite", systemImage: "star.circle")
                    }
                }
            }
            .navigationTitle("CodeGen")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: QRCode.self, inMemory: true)
    
}
