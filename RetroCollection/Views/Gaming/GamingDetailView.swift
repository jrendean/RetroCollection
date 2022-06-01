//
//  GamingDetailView.swift
//  RetroCollection
//
//  Created by JR Endean on 5/30/22.
//

import SwiftUI

struct GamingDetailView: View {
    
    @Binding var gamingCollectionItems: [GamingCollectionItem]
    @Binding var gamingCollectionItem: GamingCollectionItem
    
    var body: some View {
        Text("Gaming Details")
    }
}

#if DEBUG
struct GamingDetailView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        
        @State private var items = GamingCollectionItem.testData
        @State private var item = GamingCollectionItem.testData[0]
        
        var body: some View {
            GamingDetailView(gamingCollectionItems: $items, gamingCollectionItem: $item)
        }
    }
    
    static var previews: some View {
        Group {
            NavigationView {
                StatefulPreviewWrapper()
            }
            
            NavigationView {
                StatefulPreviewWrapper()
                    .preferredColorScheme(.dark)
            }
        }
    }
}
#endif
