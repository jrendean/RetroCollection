//
//  RetroCatalogApp.swift
//  RetroCatalog
//
//  Created by JR Endean on 12/26/21.
//

import SwiftUI

@main
struct RetroCollectionApp: App {
    private var dataManager = DataManager()
    @State private var retroCollectionItems = [RetroCollectionItem]()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            RetroCollectionView(retroCollectionItems: self.$retroCollectionItems, searchText: "")
                .onAppear(perform: {
                    dataManager.load { retroCollectionItems in
                        self.retroCollectionItems = retroCollectionItems// + retroCollectionItems + retroCollectionItems
                    }
                })
                .onChange(of: scenePhase, perform: { phase in
                    if phase == .inactive {
                        dataManager.save(retroCollectionItems: self.retroCollectionItems)
                        //dataManager.save(retroCollectionItems: RetroCollectionItem.testData)
                    }
                })
        }
    }
}
