//
//  ComponentsAddView.swift
//  RetroCollection
//
//  Created by JR Endean on 5/30/22.
//

import SwiftUI

struct ComponentsAddView: View {
    
    @Binding var componentCollectionItem: ComponentCollectionItem
    
    var body: some View {
        Text("Components Add")
    }
}

#if DEBUG
struct ComponentsAddView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State private var newItem: ComponentCollectionItem = ComponentCollectionItem()
        
        var body: some View {
            ComponentsAddView(componentCollectionItem: $newItem)
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
