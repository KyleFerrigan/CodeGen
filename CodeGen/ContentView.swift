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
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
