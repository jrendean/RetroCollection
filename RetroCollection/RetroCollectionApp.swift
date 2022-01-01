//
//  RetroCatalogApp.swift
//  RetroCatalog
//
//  Created by JR Endean on 12/26/21.
//

import SwiftUI

@main
struct RetroCollectionApp: App {

    @State private var retroCollectionItems = [RetroCollectionItem]()
    
    var body: some Scene {
        WindowGroup {
            RetroCollectionView(retroCollectionItems: self.$retroCollectionItems, searchText: "")
                .onAppear(perform: {
                    DataManager.load { retroCollectionItems in
                        self.retroCollectionItems = retroCollectionItems
                    }
                })
        }
    }
}
