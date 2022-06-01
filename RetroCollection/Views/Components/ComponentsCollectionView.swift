//
//  ComponentsCollectionView.swift
//  RetroCollection
//
//  Created by JR Endean on 5/30/22.
//

import SwiftUI

struct ComponentsCollectionView: View {
    
    @Binding var componentCollectionItems: [ComponentCollectionItem]
    
    var searchText: String
    
    var filteredItems: [ComponentCollectionItem] {
        componentCollectionItems.filter {
            searchText == "" || $0.name.contains(searchText)
        }
    }
    
    var body: some View {
        
        List {
            ForEach(filteredItems) { componentCollectionItem in
                let index = componentCollectionItems.firstIndex(where: { $0.id == componentCollectionItem.id })!
                let retroCollectionItemBinding = $componentCollectionItems[index]
                
                NavigationLink(
                    destination: ComponentsDetailView(componentCollectionItems: $componentCollectionItems, componentCollectionItem: retroCollectionItemBinding)) {
                        
                        ComponentItemRow(componentCollectionItem: componentCollectionItem)
                    }
            }
            .onDelete(perform: { offsets in componentCollectionItems.remove(atOffsets: offsets) })
            .onMove(perform: {source, destination in componentCollectionItems.move(fromOffsets: source, toOffset: destination)})
        }
    }
}

#if DEBUG
struct ComponentsCollectionView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State private var testData = ComponentCollectionItem.testData
        
        var body: some View {
            ComponentsCollectionView(componentCollectionItems: $testData, searchText: "")
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
