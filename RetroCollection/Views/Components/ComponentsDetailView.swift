//
//  ComponentsDetailView.swift
//  RetroCollection
//
//  Created by JR Endean on 5/30/22.
//

import SwiftUI

struct ComponentsDetailView: View {
    
    @Binding var componentCollectionItems: [ComponentCollectionItem]
    @Binding var componentCollectionItem: ComponentCollectionItem
    
    var body: some View {
        Text("Components Detail")
    }
}

#if DEBUG
struct ComponentsDetailView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        
        @State private var items = ComponentCollectionItem.testData
        @State private var item = ComponentCollectionItem.testData[0]
        
        var body: some View {
            ComponentsDetailView(componentCollectionItems: $items, componentCollectionItem: $item)
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
