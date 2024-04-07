//
//  FavoritesView.swift
//  CodeGen
//
//  Created by Kyle Ferrigan on 3/27/24.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [QRCode]
    
    var body: some View {
        List {
            ForEach (items){ item in
                VStack{
                    Image(uiImage: generateQRCode(from: item.data!))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .contextMenu{
                            let image = generateQRCode(from: item.data!)
                            let scaledimage = image.scalePreservingAspectRatio(targetSize: CGSize(width: 2560, height: 2560))
                            
                            ShareLink(item: Image(uiImage: scaledimage), preview: SharePreview("My QR Code", image: Image(uiImage: image)))
                        }
                    Text(item.data!)
                }
            }
            .onDelete(perform: deleteItems)
        }
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
                do {
                    try modelContext.save()
                } catch {
                    print("Could not save context after del")
                }
                
            }
        }
    }
}

#Preview {
    FavoritesView()
        .modelContainer(for: QRCode.self, inMemory: true)
}
