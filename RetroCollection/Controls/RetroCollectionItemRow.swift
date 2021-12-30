//
//  CollectionItemRow.swift
//  RetroCatalog
//
//  Created by JR Endean on 12/26/21.
//

import SwiftUI

struct RetroCollectionItemRow: View {
    var retroCollectionItem: RetroCollectionItem
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Image(systemName: retroCollectionItem.type == "Laptop" ? "laptopcomputer" : "desktopcomputer")
                    .symbolRenderingMode(.hierarchical)
                    .font(.largeTitle)
                    .imageScale(.large)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("\(retroCollectionItem.manufacturer) \(retroCollectionItem.name)")
                        .font(.headline)
                    Text(retroCollectionItem.processorInfo)
                    Text(retroCollectionItem.totalRam)
                }
            }.padding()
        }.padding(.trailing)
    }
}

#if DEBUG
struct CollectionItemRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RetroCollectionItemRow(retroCollectionItem: RetroCollectionItem.testData[0])
                .previewLayout(.fixed(width: 400, height: 100))
            
            RetroCollectionItemRow(retroCollectionItem: RetroCollectionItem.testData[1])
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 400, height: 100))
        }
    }
}
#endif
