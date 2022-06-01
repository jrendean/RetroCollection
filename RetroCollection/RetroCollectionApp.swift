//
//  RetroCatalogApp.swift
//  RetroCatalog
//
//  Created by JR Endean on 12/26/21.
//

import SwiftUI

@main
struct RetroCollectionApp: App {

    @State private var computerCollectionItems = [ComputerCollectionItem]()
    @State private var componentCollectionItems = [ComponentCollectionItem]()
    @State private var gamingCollectionItems = [GamingCollectionItem]()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            RetroCollectionView(computerCollectionItems: self.$computerCollectionItems, componentCollectionItems: self.$componentCollectionItems, gamingCollectionItems: self.$gamingCollectionItems, searchText: "")
                .onAppear(perform: {
                    DataManager.loadComputersCollection { computerCollectionItems in
                        self.computerCollectionItems = computerCollectionItems
                    }
                    DataManager.loadComponentsCollection { componentCollectionItems in
                        self.componentCollectionItems = componentCollectionItems
                    }
                    DataManager.loadGamingCollection { gamingCollectionItems in
                        self.gamingCollectionItems = gamingCollectionItems
                    }
                })
                .onChange(of: scenePhase, perform: { phase in
                    if phase == .inactive {
                        DataManager.saveComputersCollection(computerCollectionItems: self.computerCollectionItems)
                        DataManager.saveComponentsCollection(componentsCollectionItems: self.componentCollectionItems)
                        DataManager.saveGamingCollection(gamingCollectionItems: self.gamingCollectionItems)
                    }
                })
        }
    }
}
