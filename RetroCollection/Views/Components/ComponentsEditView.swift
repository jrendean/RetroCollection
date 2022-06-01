//
//  ComponentsEditView.swift
//  RetroCollection
//
//  Created by JR Endean on 5/30/22.
//

import SwiftUI

struct ComponentsEditView: View {
    
    @Binding var componentCollectionItem: ComponentCollectionItem
     
    var body: some View {
        Text("Components Edit")
    }
}

#if DEBUG
struct ComponentsEditView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State private var item = ComponentCollectionItem.testData[0]
        
        var body: some View {
            ComponentsEditView(componentCollectionItem: $item)
        }
    }
    
    static var previews: some View {
        NavigationView {
            StatefulPreviewWrapper()
        }
    }
}
#endif
