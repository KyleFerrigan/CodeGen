//
//  CodeGenApp.swift
//  CodeGen
//
//  Created by Kyle Ferrigan on 3/8/24.
//

import SwiftUI
import SwiftData
import Foundation
import CloudKit
import CoreData



@main
struct CodeGenApp: App {
    @AppStorage("userAccentChoice") var userAccentChoice: Int = -1

    var favQRCodes: ModelContainer = createQRCloudContainer()

    // MARK: App
    var body: some Scene {
        WindowGroup {
            ContentView()
                .accentColor(accentColorCheck())
        }
        .modelContainer(favQRCodes)
    }
    
    //MARK: Check Accent Color
    func accentColorCheck()->Color{
        switch userAccentChoice {
        case 0:
            return .red
        case 1:
            return .green
        case 2:
            return .blue
        case 3:
            return .orange
        case 4:
            return .purple
        case 5:
            return .yellow
        case 6:
            return .mint
        case 7:
            return .gray
        default:
            return .accentColor
        }
    }
}

//MARK: Model Container
func createQRCloudContainer() -> ModelContainer {
    let schema = Schema([QRCode.self,])
    let config = ModelConfiguration(for: QRCode.self, isStoredInMemoryOnly: false)
    do {
        if isICloudContainerAvailable(){
            // MARK: CloudKit Container Only
            // Use an autorelease pool to make sure Swift deallocates the persistent
            // container before setting up the SwiftData stack.
            try autoreleasepool {
                let desc = NSPersistentStoreDescription(url: config.url)
                let opts = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.CodeGen.QRCodes")
                desc.cloudKitContainerOptions = opts
                // Load the store synchronously so it completes before initializing the
                // CloudKit schema.
                desc.shouldAddStoreAsynchronously = false
                if let mom = NSManagedObjectModel.makeManagedObjectModel(for: [QRCode.self]) {
                    let container = NSPersistentCloudKitContainer(name: "QR Codes", managedObjectModel: mom)
                    container.persistentStoreDescriptions = [desc]
                    container.loadPersistentStores {_, err in
                        if let err {
                            fatalError(err.localizedDescription)
                        }
                    }
                    // Initialize the CloudKit schema after the store finishes loading.
                    try container.initializeCloudKitSchema()
                    // Remove and unload the store from the persistent container.
                    if let store = container.persistentStoreCoordinator.persistentStores.first {
                        try container.persistentStoreCoordinator.remove(store)
                    }
                }
            }
        } // MARK: CloudKit END
        return try ModelContainer(for: schema, configurations: config)
    } catch {
        fatalError(error.localizedDescription)
    }
}

//MARK: Cloudkit Check
// Check if Cloudkit Container can be accessed
func isICloudContainerAvailable()->Bool {
    var accountOnline: Bool = false
    // Check iCloud account status (access to the apps private database)
    CKContainer.default().accountStatus { (accountStatus, error) in
        
        if accountStatus == .available {
            print("iCloud app container and private database is available")
            accountOnline = true
        } else {
            print("iCloud not available \(String(describing: error?.localizedDescription))")
            accountOnline = false
        }
    }
    return accountOnline
}
