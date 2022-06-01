//
//  ComputersCollectionView.swift
//  RetroCollection
//
//  Created by JR Endean on 5/30/22.
//

import SwiftUI

struct ComputersCollectionView: View {
    
    @Binding var computerCollectionItems: [ComputerCollectionItem]
    
    var searchText: String
    
    var filteredItems: [ComputerCollectionItem] {
        computerCollectionItems.filter {
            searchText == "" || $0.name.contains(searchText)
        }
    }
    
    var body: some View {
        
        List {
            ForEach(filteredItems) { computerCollectionItem in
                let index = computerCollectionItems.firstIndex(where: { $0.id == computerCollectionItem.id })!
                let retroCollectionItemBinding = $computerCollectionItems[index]
                
                NavigationLink(
                    destination: ComputersDetailView(computerCollectionItems: $computerCollectionItems, computerCollectionItem: retroCollectionItemBinding)) {
                        
                        ComputersItemRow(computerCollectionItem: computerCollectionItem)
                    }
            }
            .onDelete(perform: { offsets in computerCollectionItems.remove(atOffsets: offsets) })
            .onMove(perform: {source, destination in computerCollectionItems.move(fromOffsets: source, toOffset: destination)})
        }
    }
}

#if DEBUG
struct ComputersMainView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State private var testData = ComputerCollectionItem.testData
        
        var body: some View {
            ComputersCollectionView(computerCollectionItems: $testData, searchText: "")
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
