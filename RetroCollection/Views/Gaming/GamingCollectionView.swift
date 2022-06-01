//
//  GamingCollectionView.swift
//  RetroCollection
//
//  Created by JR Endean on 5/30/22.
//

import SwiftUI

struct GamingCollectionView: View {
    
    @Binding var gamingCollectionItems: [GamingCollectionItem]
    
    var searchText: String
    
    var filteredItems: [GamingCollectionItem] {
        gamingCollectionItems.filter {
            searchText == "" || $0.name.contains(searchText)
        }
    }
    
    var body: some View {
        
        List {
            ForEach(filteredItems) { gamingCollectionItem in
                let index = gamingCollectionItems.firstIndex(where: { $0.id == gamingCollectionItem.id })!
                let retroCollectionItemBinding = $gamingCollectionItems[index]
                
                NavigationLink(
                    destination: GamingDetailView(gamingCollectionItems: $gamingCollectionItems, gamingCollectionItem: retroCollectionItemBinding)) {
                        
                        GamingItemRow(gamingCollectionItem: gamingCollectionItem)
                    }
            }
            .onDelete(perform: { offsets in gamingCollectionItems.remove(atOffsets: offsets) })
            .onMove(perform: {source, destination in gamingCollectionItems.move(fromOffsets: source, toOffset: destination)})
        }
    }
}

#if DEBUG
struct GamingCollectionView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State private var testData = GamingCollectionItem.testData
        
        var body: some View {
            GamingCollectionView(gamingCollectionItems: $testData, searchText: "")
        }
    }
    
    static var previews: some View {
         
        Group {
            StatefulPreviewWrapper()
        
            StatefulPreviewWrapper()
                .preferredColorScheme(.dark)
        }
    }
}
#endif
