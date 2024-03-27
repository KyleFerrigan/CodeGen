//
//  ContentView.swift
//  CodeGen
//
//  Created by Kyle Ferrigan on 3/8/24.
//

import SwiftUI
import SwiftData
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    @State var textIn: String = ""

    var body: some View {
        NavigationSplitView {
            List {
                
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
                
                TextField("Insert data here", text: $textIn)
                
                /* DEFAULT DATA
                 ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                */
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(
                            action: {
                                //TODO: Open Settings Page
                                print("Settings Button tapped!")
                            }
                        ){
                            Label("Settings", systemImage: "gear")
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button(
                            action: {
                                //TODO: Add current QR code string to store items (use cloudkit if possible)
                                print("Favorite Button tapped!")
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
        detail: {
            Text("Select an item")
        }
    }
    
    // MARK: QR Code Generator
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let qrCodeImage = filter.outputImage {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    /* DEFAULT DATA
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    */
}

extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = max(widthRatio, heightRatio)
        
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )
        
        UIGraphicsBeginImageContextWithOptions(scaledImageSize, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.interpolationQuality = .none
        self.draw(in: CGRect(origin: .zero, size: scaledImageSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return scaledImage
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
